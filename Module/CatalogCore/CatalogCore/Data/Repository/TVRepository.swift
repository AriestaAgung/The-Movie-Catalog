//
//  MovieRepository.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RxSwift
import CatalogCommon

public protocol TVRepositoryProtocol {
    func getTVList() -> Observable<[TVListModel]>
    func getTVDetail( id: Int) -> Observable<TVListModel>
    
    func getFavoriteTVList() -> Observable<[TVListModel]>
    func getFavoriteTVDetail(id: Int) -> Observable<TVListModel>
    
    func addTVFavorite(item: TVListEntity) -> Observable<Bool>
}

public final class TVRepository: NSObject {
    public typealias TVInstance = (LocaleDataSource, RemoteDataSource) -> TVRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    public static let shared: TVInstance = { localeRepo, remoteRepo in
        return TVRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension TVRepository: TVRepositoryProtocol {
    public func addTVFavorite(item: TVListEntity) -> RxSwift.Observable<Bool> {
        return self.locale.addTVFavoriteDetail(item: item)
    }
    
    public func getFavoriteTVList() -> RxSwift.Observable<[TVListModel]> {
        return self.locale.getFavoriteTVList()
            .map{HomeTVMapper.mapEntityToDomain(entities: $0).filter{$0.isFavorite == true}}
            .filter{!$0.isEmpty}
        
    }
    
    public func getFavoriteTVDetail(id: Int) -> RxSwift.Observable<TVListModel> {
        return self.locale.getFavoriteTVDetail(id: id)
            .map{item in
                return TVListModel(id: item.id, title: item.title, posterImage: item.posterImage, desc: item.desc, firstAiring: item.firstAiring, isFavorite: item.isFavorite)
            }
            .filter{$0.id == id && $0.isFavorite == true}
    }
    
    
    public func getTVList() -> Observable<[TVListModel]> {
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
    public func getTVDetail(id: Int) -> RxSwift.Observable<TVListModel> {
        return self.locale.getTVDetail(id: id)
            .map{ item in
                return TVListModel(id: item.id, title: item.title, posterImage: item.posterImage, desc: item.desc, firstAiring: item.firstAiring, isFavorite: item.isFavorite)
            }
            .filter{$0.id == id}
            .ifEmpty(switchTo: self.remote.getTVDetail(id: id)
                .map{ item in
                    let entity = TVListEntity()
                    entity.id = item?.id ?? 0
                    entity.title = item?.name ?? "n/a"
                    entity.firstAiring = item?.firstAirDate ?? "n/a"
                    entity.posterImage = item?.posterPath ?? "n/a"
                    return entity
                }
                .flatMap{self.locale.addTVDetail(item: $0)}
                .filter{$0}
                .flatMap{ _ in self.locale.getTVDetail(id: id)
                        .map{ item in
                            TVListModel(id: item.id , title: item.title , posterImage:  (item.posterImage ), desc: item.desc , firstAiring: item.firstAiring, isFavorite: item.isFavorite )
                        }
                        .filter{$0.id == id}
                    
                }
            )
    }
}
