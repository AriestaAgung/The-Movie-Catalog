//
//  HomePresenter.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RxSwift

class HomePresenter: ObservableObject {
    private let disposeBag = DisposeBag()
    private let router = HomeRouter()
    private let useCase: HomeUseCase
    
    @Published var tvList: [TVListModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false

    
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
    
    
}
