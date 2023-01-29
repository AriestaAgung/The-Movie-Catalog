//
//  DetailPresenter.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 06/01/23.
//

import Foundation
import CatalogCore
import RxSwift

public class DetailPresenter: ObservableObject {
    private let useCase: DetailUseCase
    private let favoriteUseCase: FavoriteUseCase
    private let disposeBag = DisposeBag()
    
    @Published var favTvList: [TVListModel] = []
    @Published var favMovieList: [MovieListModel] = []
    @Published var tvDetail: TVListModel? = nil
    @Published var movieDetail: MovieListModel? = nil
    
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var isMovie: Bool = false
    @Published var selectedID: Int = 0
    
    public init(useCase: DetailUseCase, favoriteUseCase: FavoriteUseCase, isMovie: Bool, selectedID: Int = 0) {
        self.useCase = useCase
        self.isMovie = isMovie
        self.selectedID = selectedID
        self.favoriteUseCase = favoriteUseCase
    }
    
    public func getMovie(id: Int) {
        loadingState = true
        self.movieDetail = nil
        useCase.getMovieDetail(id: selectedID)
            .observe(on: MainScheduler.instance)
            .subscribe{ res in
                self.movieDetail = res
                print("detail title: \(res.title)")
            } onError: { err in
                self.errorMessage = err.localizedDescription
                print(self.errorMessage)
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    public func getTv(id: Int) {
        loadingState = true
        self.tvDetail = nil
        useCase.getTVDetail(id: selectedID)
            .observe(on: MainScheduler.instance)
            .subscribe{ res in
                self.tvDetail = res
                print("detail title: \(res.title)")
            } onError: { err in
                self.errorMessage = err.localizedDescription
                print(self.errorMessage)
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    public func getFavTVList() {
        favoriteUseCase.getTVFavoriteList()
            .observe(on: MainScheduler.instance)
            .subscribe{ res in
                dump(res)
                self.favTvList = res.filter{$0.isFavorite == true}
            } onError: { err in
                self.errorMessage = err.localizedDescription
                print(self.errorMessage)
                
            } onCompleted: {
                self.loadingState = false
                print(self.favTvList.count)
            }.disposed(by: disposeBag)
    }
    
    public func getFavMovieList() {
        favoriteUseCase.getMovieFavoriteList()
            .observe(on: MainScheduler.instance)
            .subscribe{ res in
                self.favMovieList = res.filter{$0.isFavorite == true}
            } onError: { err in
                self.errorMessage = err.localizedDescription
                print(self.errorMessage)
            } onCompleted: {
                self.loadingState = false
                print(self.favMovieList.count)
            }.disposed(by: disposeBag)
    }
    
    public func getFavMovie(id: Int) {
        loadingState = true
        self.movieDetail = nil
        favoriteUseCase.getMovieFavoriteDetail(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe{ res in
                self.movieDetail = res
                print("detail title: \(res.title)")
            } onError: { err in
                self.errorMessage = err.localizedDescription
                print(self.errorMessage)
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    public func getFavTv(id: Int) {
        loadingState = true
        self.tvDetail = nil
        favoriteUseCase.getTVFavoriteDetail(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe{ res in
                self.tvDetail = res
                print("detail title: \(res.title)")
            } onError: { err in
                self.errorMessage = err.localizedDescription
                print(self.errorMessage)
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    public func addTVFavorite(completion: @escaping () -> ()) {
        let entity = TVListEntity()
        dump(tvDetail)
        if let tvDetail = tvDetail {
            entity.id = tvDetail.id
            entity.title = tvDetail.title
            entity.desc = tvDetail.desc
            entity.posterImage = tvDetail.posterImage
            entity.firstAiring = tvDetail.firstAiring
            entity.isFavorite = tvDetail.isFavorite
            favoriteUseCase.addTVFavorite(item:entity)
                .subscribe{ res in
                    print(res)
                } onError: { err in
                    print(err.localizedDescription)
                } onCompleted: {
                    completion()
                    self.loadingState = false
                }.disposed(by: disposeBag)
        }
    }
    
    public func addMovieFavorite(completion: @escaping () -> ()) {
        let entity = MovieListEntity()
        dump(movieDetail)
        if let tvDetail = movieDetail {
            entity.id = tvDetail.id
            entity.title = tvDetail.title
            entity.desc = tvDetail.desc
            entity.posterImage = tvDetail.posterImage
            entity.firstAiring = tvDetail.firstAiring
            entity.isFavorite = tvDetail.isFavorite
            favoriteUseCase.addMovieFavorite(item:entity)
                .subscribe{ res in
                    print(res)
                } onError: { err in
                    print(err.localizedDescription)
                } onCompleted: {
                    completion()
                    self.loadingState = false
                }.disposed(by: disposeBag)
        }
    }
    
}
