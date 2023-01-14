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
    func getMovieDetail(id: Int) -> Observable<MovieListModel>
    
    func getFavoriteMovieList() -> Observable<[MovieListModel]>
    func getFavoriteMovieDetail(id: Int) -> Observable<MovieListModel>
    
    func addMovieFavorite(item: MovieListEntity) -> Observable<Bool>
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
    func addMovieFavorite(item: MovieListEntity) -> Observable<Bool> {
        return self.locale.addMovieFavoriteDetail(item: item)
    }
    
    func getFavoriteMovieList() -> RxSwift.Observable<[MovieListModel]> {
        return self.locale.getFavoriteMovieList()
            .map{HomeMovieMapper.mapEntityToDomain(entities: $0).filter{$0.isFavorite == true}}
            .filter{!$0.isEmpty}
    }
    
    func getFavoriteMovieDetail(id: Int) -> RxSwift.Observable<MovieListModel> {
        return self.locale.getFavoriteMovieDetail(id: id)
            .map{item in
                return MovieListModel(id: item.id, title: item.title, posterImage: item.posterImage, desc: item.desc, firstAiring: item.firstAiring, isFavorite: item.isFavorite)
            }
            .filter{$0.id == id && $0.isFavorite == true}
    }
    
    
    
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
    
    func getMovieDetail(id: Int) -> Observable<MovieListModel> {
        return self.locale.getMovieDetail(id: id)
            .map{ item in
                return MovieListModel(id: item.id, title: item.title, posterImage: item.posterImage, desc: item.desc, firstAiring: item.firstAiring, isFavorite: item.isFavorite)
            }
            .filter{ $0.id == id }
            .ifEmpty(switchTo: self.remote.getMovieDetail(id: id)
                .map{ item in
                    let entity = MovieListEntity()
                    entity.id = item?.id ?? 0
                    entity.title = item?.title ?? "n/a"
                    entity.firstAiring = item?.releaseDate ?? "n/a"
                    entity.posterImage = item?.posterPath ?? "n/a"
                    entity.isFavorite = false // Automatically false when get from response to refresh the data
                    return entity
                }
                .flatMap{ self.locale.addMovieDetail(item: $0) }
                .filter{ $0 }
                .flatMap{ _ in self.locale.getMovieDetail(id: id)
                        .map{ item in
                            MovieListModel(id: item.id , title: item.title , posterImage: (item.posterImage ), desc: item.desc , firstAiring: item.firstAiring, isFavorite: item.isFavorite )
                        }
                        .filter{$0.id == id}
                }
            )
    }
}
