//
//  FavoriteUseCase.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 10/01/23.
//

import Foundation
import RxSwift

public protocol FavoriteUseCase {
    func getTVFavoriteList() -> Observable<[TVListModel]>
    func getMovieFavoriteList() -> Observable<[MovieListModel]>
    
    func getTVFavoriteDetail(id: Int) -> Observable<TVListModel>
    func getMovieFavoriteDetail(id: Int) -> Observable<MovieListModel>
    
    func addTVFavorite(item: TVListEntity) -> Observable<Bool>
    func addMovieFavorite(item: MovieListEntity) -> Observable<Bool>
}

public class FavoriteInteractor: FavoriteUseCase {
    private let TVRepository: TVRepositoryProtocol
    private let movieRepository: MovieRepositoryProtocol
    
    public func addTVFavorite(item: TVListEntity) -> RxSwift.Observable<Bool> {
        TVRepository.addTVFavorite(item: item)
    }
    
    public func addMovieFavorite(item: MovieListEntity) -> RxSwift.Observable<Bool> {
        movieRepository.addMovieFavorite(item: item)
    }
    

    public init(TVRepository: TVRepositoryProtocol, movieRepository: MovieRepositoryProtocol) {
        self.TVRepository = TVRepository
        self.movieRepository = movieRepository
    }
    
    public func getTVFavoriteList() -> RxSwift.Observable<[TVListModel]> {
        TVRepository.getTVList()
    }
    
    public func getMovieFavoriteList() -> RxSwift.Observable<[MovieListModel]> {
        movieRepository.getMovieList()
    }
    
    public func getTVFavoriteDetail(id: Int) -> RxSwift.Observable<TVListModel> {
        TVRepository.getFavoriteTVDetail(id: id)
    }
    
    public func getMovieFavoriteDetail(id: Int) -> RxSwift.Observable<MovieListModel> {
        movieRepository.getMovieDetail(id: id)
    }
    
}
