//
//  DetailPresenter.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 06/01/23.
//

import Foundation
import RxSwift

class DetailPresenter: ObservableObject {
    private let useCase: DetailUseCase
    private let disposeBag = DisposeBag()
    
    @Published var tvDetail: TVListModel? = nil
    @Published var movieDetail: MovieListModel? = nil
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var isMovie: Bool = false
    @Published var selectedID: Int = 0
    
    init(useCase: DetailUseCase, isMovie: Bool, selectedID: Int = 0) {
        self.useCase = useCase
        self.isMovie = isMovie
        self.selectedID = selectedID
    }
    
    func getMovie(id: Int) {
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
    
    func getTv(id: Int) {
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
    
}
