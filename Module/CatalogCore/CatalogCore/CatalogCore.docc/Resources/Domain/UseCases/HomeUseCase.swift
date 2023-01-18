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
    func getMovieHomeList() -> Observable<[MovieListModel]>
}

class HomeInteractor: HomeUseCase {
    
    private let TVRepository: TVRepositoryProtocol
    private let movieRepository: MovieRepositoryProtocol

    init(TVRepository: TVRepositoryProtocol, movieRepository: MovieRepositoryProtocol) {
        self.TVRepository = TVRepository
        self.movieRepository = movieRepository
    }

    func getTVHomeList() -> Observable<[TVListModel]> {
        return TVRepository.getTVList()
    }
    func getMovieHomeList() -> Observable<[MovieListModel]> {
        return movieRepository.getMovieList()
    }
}
