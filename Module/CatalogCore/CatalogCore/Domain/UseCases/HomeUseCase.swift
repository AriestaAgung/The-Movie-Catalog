//
//  HomeUseCase.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RxSwift

public protocol HomeUseCase {
    func getTVHomeList() -> Observable<[TVListModel]>
    func getMovieHomeList() -> Observable<[MovieListModel]>
}

public class HomeInteractor: HomeUseCase {
    
    private let TVRepository: TVRepositoryProtocol
    private let movieRepository: MovieRepositoryProtocol

    public init(TVRepository: TVRepositoryProtocol, movieRepository: MovieRepositoryProtocol) {
        self.TVRepository = TVRepository
        self.movieRepository = movieRepository
    }

    public func getTVHomeList() -> Observable<[TVListModel]> {
        return TVRepository.getTVList()
    }
    public func getMovieHomeList() -> Observable<[MovieListModel]> {
        return movieRepository.getMovieList()
    }
}
