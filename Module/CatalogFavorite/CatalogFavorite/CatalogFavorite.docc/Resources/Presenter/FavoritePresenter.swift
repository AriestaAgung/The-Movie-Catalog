//
//  FavoritePresenter.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 10/01/23.
//

import Foundation
import RxSwift
import SwiftUI

class FavoritePresenter: ObservableObject {
    private let disposeBag = DisposeBag()
    private let useCase: FavoriteUseCase
    let router = HomeRouter()

    
    @Published var tvList: [TVListModel] = []
    @Published var movieList: [MovieListModel] = []
    @Published var tvDetail: TVListModel? = nil
    @Published var movieDetail: MovieListModel? = nil
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    
    init(useCase: FavoriteUseCase) {
        self.useCase = useCase
    }
    
    func getTVList() {
        useCase.getTVFavoriteList()
            .observe(on: MainScheduler.instance)
            .subscribe{ res in
                dump(res)
                self.tvList = res.filter{$0.isFavorite == true}
            } onError: { err in
                self.errorMessage = err.localizedDescription
                print(self.errorMessage)
                
            } onCompleted: {
                self.loadingState = false
                print(self.tvList.count)
            }.disposed(by: disposeBag)
    }
    
    func getMovieList() {
        useCase.getMovieFavoriteList()
            .observe(on: MainScheduler.instance)
            .subscribe{ res in
                self.movieList = res.filter{$0.isFavorite == true}
            } onError: { err in
                self.errorMessage = err.localizedDescription
                print(self.errorMessage)
            } onCompleted: {
                self.loadingState = false
                print(self.movieList.count)
            }.disposed(by: disposeBag)
    }
    
    func getMovie(id: Int) {
        loadingState = true
        self.movieDetail = nil
        useCase.getMovieFavoriteDetail(id: id)
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
    
    func getTv(id: Int) {
        loadingState = true
        self.tvDetail = nil
        useCase.getTVFavoriteDetail(id: id)
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
    
    func addTVFavorite(completion: @escaping () -> ()) {
        let entity = TVListEntity()
        dump(tvDetail)
        if let tvDetail = tvDetail {
            entity.id = tvDetail.id
            entity.title = tvDetail.title
            entity.desc = tvDetail.desc
            entity.posterImage = tvDetail.posterImage
            entity.firstAiring = tvDetail.firstAiring
            entity.isFavorite = tvDetail.isFavorite
            useCase.addTVFavorite(item:entity)
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
    
    func addMovieFavorite(completion: @escaping () -> ()) {
        let entity = MovieListEntity()
        dump(movieDetail)
        if let tvDetail = movieDetail {
            entity.id = tvDetail.id
            entity.title = tvDetail.title
            entity.desc = tvDetail.desc
            entity.posterImage = tvDetail.posterImage
            entity.firstAiring = tvDetail.firstAiring
            entity.isFavorite = tvDetail.isFavorite
            useCase.addMovieFavorite(item:entity)
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
    
    
    func linkBuilder<Content: View>(
        isMovie: Bool,
        id: Int,
        @ViewBuilder content: () -> Content
    ) -> some View{
        NavigationLink(destination: router.showDetailView(id: id, isMovie: isMovie)) {
            content()
        }
    }
}
