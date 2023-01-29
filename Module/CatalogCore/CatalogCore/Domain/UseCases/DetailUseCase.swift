//
//  DetailUseCase.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 05/01/23.
//

import Foundation
import RxSwift

public protocol DetailUseCase {
    func getTVDetail(id: Int) -> Observable<TVListModel>
    func getMovieDetail(id: Int) -> Observable<MovieListModel>
    
    
    //Favorite
    func getTVFavoriteList() -> Observable<[TVListModel]>
    func getMovieFavoriteList() -> Observable<[MovieListModel]>
    
    func getTVFavoriteDetail(id: Int) -> Observable<TVListModel>
    func getMovieFavoriteDetail(id: Int) -> Observable<MovieListModel>
    
    func addTVFavorite(item: TVListEntity) -> Observable<Bool>
    func addMovieFavorite(item: MovieListEntity) -> Observable<Bool>
}

public class DetailInteractor: DetailUseCase {
    
    private let TVRepository: TVRepositoryProtocol
    private let movieRepository: MovieRepositoryProtocol

    public init(TVRepository: TVRepositoryProtocol, movieRepository: MovieRepositoryProtocol) {
        self.TVRepository = TVRepository
        self.movieRepository = movieRepository
    }
    
    public func getTVDetail(id: Int) -> Observable<TVListModel> {
        return self.TVRepository.getTVDetail(id: id)
    }
    
    public func getMovieDetail(id: Int) -> Observable<MovieListModel> {
        return self.movieRepository.getMovieDetail(id: id)
    }
    
    //Favorite
    public func addTVFavorite(item: TVListEntity) -> RxSwift.Observable<Bool> {
        TVRepository.addTVFavorite(item: item)
    }
    
    public func addMovieFavorite(item: MovieListEntity) -> RxSwift.Observable<Bool> {
        movieRepository.addMovieFavorite(item: item)
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
