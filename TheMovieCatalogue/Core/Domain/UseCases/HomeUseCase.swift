//
//  HomeUseCase.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func getTVHomeList() -> Observable<[TVListModel]>
}

class HomeInteractor: HomeUseCase {
    private let TVRepository: TVRepositoryProtocol

    init(TVRepository: TVRepositoryProtocol) {
        self.TVRepository = TVRepository
    }

    func getTVHomeList() -> Observable<[TVListModel]> {
        return TVRepository.getTVList()
    }
}
