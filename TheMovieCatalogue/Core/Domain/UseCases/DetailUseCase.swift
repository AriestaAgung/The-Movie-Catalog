//
//  DetailUseCase.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 05/01/23.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    func getTVDetail(id: Int) -> Observable<TVListModel>
    func getMovieDetail(id: Int) -> Observable<MovieListModel>
}

class DetailInteractor: DetailUseCase {
    
    private let TVRepository: TVRepositoryProtocol
    private let movieRepository: MovieRepositoryProtocol

    init(TVRepository: TVRepositoryProtocol, movieRepository: MovieRepositoryProtocol) {
        self.TVRepository = TVRepository
        self.movieRepository = movieRepository
    }
    
    func getTVDetail(id: Int) -> Observable<TVListModel> {
        return self.TVRepository.getTVDetail(id: id)
    }
    
    func getMovieDetail(id: Int) -> Observable<MovieListModel> {
        return self.movieRepository.getMovieDetail(id: id)
    }
    
}
