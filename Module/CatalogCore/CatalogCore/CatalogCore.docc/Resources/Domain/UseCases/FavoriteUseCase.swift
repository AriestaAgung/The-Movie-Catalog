//
//  FavoriteUseCase.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 10/01/23.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func getTVFavoriteList() -> Observable<[TVListModel]>
    func getMovieFavoriteList() -> Observable<[MovieListModel]>
    
    func getTVFavoriteDetail(id: Int) -> Observable<TVListModel>
    func getMovieFavoriteDetail(id: Int) -> Observable<MovieListModel>
    
    func addTVFavorite(item: TVListEntity) -> Observable<Bool>
    func addMovieFavorite(item: MovieListEntity) -> Observable<Bool>
}

class FavoriteInteractor: FavoriteUseCase {
    private let TVRepository: TVRepositoryProtocol
    private let movieRepository: MovieRepositoryProtocol
    
    func addTVFavorite(item: TVListEntity) -> RxSwift.Observable<Bool> {
        TVRepository.addTVFavorite(item: item)
    }
    
    func addMovieFavorite(item: MovieListEntity) -> RxSwift.Observable<Bool> {
        movieRepository.addMovieFavorite(item: item)
    }
    

    init(TVRepository: TVRepositoryProtocol, movieRepository: MovieRepositoryProtocol) {
        self.TVRepository = TVRepository
        self.movieRepository = movieRepository
    }
    
    func getTVFavoriteList() -> RxSwift.Observable<[TVListModel]> {
        TVRepository.getTVList()
    }
    
    func getMovieFavoriteList() -> RxSwift.Observable<[MovieListModel]> {
        movieRepository.getMovieList()
    }
    
    func getTVFavoriteDetail(id: Int) -> RxSwift.Observable<TVListModel> {
        TVRepository.getFavoriteTVDetail(id: id)
    }
    
    func getMovieFavoriteDetail(id: Int) -> RxSwift.Observable<MovieListModel> {
        movieRepository.getMovieDetail(id: id)
    }
    
}
