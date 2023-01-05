//
//  MovieRepository.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 05/01/23.
//

import Foundation
import RxSwift

protocol MovieRepositoryProtocol {
    func getMovieList() -> Observable<[MovieListModel]>
}

final class MovieRepository: NSObject {
    typealias movieInstance = (LocaleDataSource, RemoteDataSource) -> MovieRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let shared: movieInstance = { localeRepo, remoteRepo in
        return MovieRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    func getMovieList() -> Observable<[MovieListModel]> {
        return self.locale.getMovieList()
            .map{ HomeMovieMapper.mapEntityToDomain(entities: $0)}
            .filter{ !$0.isEmpty }
            .ifEmpty(switchTo: self.remote.getMovieList()
                .map{ HomeMovieMapper.mapResponseToEntities(response: $0?.results) }
                .flatMap{self.locale.addMovieList(from: $0)}
                .filter{$0}
                .flatMap{ _ in self.locale.getMovieList()
                        .map{ HomeMovieMapper.mapEntityToDomain(entities: $0) }
                }
            )
    }
}
