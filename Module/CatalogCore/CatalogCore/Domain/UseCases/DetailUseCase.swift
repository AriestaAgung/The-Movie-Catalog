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
    
    
    
}
