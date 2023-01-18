//
//  HomePresenter.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RxSwift
import SwiftUI

class HomePresenter: ObservableObject {
    private let disposeBag = DisposeBag()
    let router = HomeRouter()
    private let useCase: HomeUseCase
    
    @Published var tvList: [TVListModel] = []
    @Published var movieList: [MovieListModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false

    @State private var tabBar: UITabBar! = nil

    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    func getTVList() {
        loadingState = true
        useCase.getTVHomeList()
            .observe(on: MainScheduler.instance)
            .subscribe{ res in
                self.tvList = res
            } onError: { err in
                self.errorMessage = err.localizedDescription
                print(self.errorMessage)
            } onCompleted: {
                self.loadingState = false
                print(self.tvList.count)
            }.disposed(by: disposeBag)
    }
    
    func getMovieList() {
        loadingState = true
        useCase.getMovieHomeList()
            .observe(on: MainScheduler.instance)
            .subscribe{ res in
                self.movieList = res
            } onError: { err in
                self.errorMessage = err.localizedDescription
                print(self.errorMessage)
            } onCompleted: {
                self.loadingState = false
                print(self.movieList.count)
            }.disposed(by: disposeBag)
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
