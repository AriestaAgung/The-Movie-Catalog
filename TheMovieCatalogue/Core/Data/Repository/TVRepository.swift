//
//  MovieRepository.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RxSwift

protocol TVRepositoryProtocol {
    func getTVList() -> Observable<[TVListModel]>
}

final class TVRepository: NSObject {
    typealias TVInstance = (LocaleDataSource, RemoteDataSource) -> TVRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
      self.locale = locale
      self.remote = remote
    }

    static let shared: TVInstance = { localeRepo, remoteRepo in
      return TVRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension TVRepository: TVRepositoryProtocol {
    func getTVList() -> Observable<[TVListModel]> {
        return self.locale.getTVList()
            .map{ HomeTVMapper.mapEntityToDomain(entities: $0)}
            .filter{ !$0.isEmpty }
            .ifEmpty(switchTo: self.remote.getTVList()
                .map{ HomeTVMapper.mapResponseToEntities(response: $0?.results) }
                .flatMap{self.locale.addTVList(from: $0)}
                .filter{$0}
                .flatMap{ _ in self.locale.getTVList()
                        .map{ HomeTVMapper.mapEntityToDomain(entities: $0) }
                }
            )
    }
    
    
}
