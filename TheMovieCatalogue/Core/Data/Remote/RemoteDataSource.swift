//
//  RemoteDataSource.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RxSwift
import Alamofire

protocol RemoteDataSourceProtocol {
    func getTVList() -> Observable<TVPopularResponse?>
    func getMovieList() -> Observable<MoviePopularResponse?>
    func getMovieDetail(id: Int) -> Observable<MovieDetailResponse?>
    func getTVDetail(id: Int) -> Observable<TVDetailResponse?>
}

final class RemoteDataSource: NSObject {
    private override init() { }
    
    static let shared: RemoteDataSource = RemoteDataSource()
    
    let header: HTTPHeaders = [
        "Authorization": "Bearer \(API.apiKey)",
        "Content-Type": "application/json",
    ]
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getMovieDetail(id: Int) -> Observable<MovieDetailResponse?> {
        return Observable<MovieDetailResponse?>.create{ observer in
            if let url = GeneralHelper.getCustomPath(id: id.description, baseEndpoint: Endpoints.Gets.movieDetail.url) {
                print(url)
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MovieDetailResponse.self){ response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure(let err):
                            observer.onError(err)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func getTVDetail(id: Int) -> Observable<TVDetailResponse?> {
        return Observable<TVDetailResponse?>.create{ observer in
            if let url = GeneralHelper.getCustomPath(id: id.description, baseEndpoint: Endpoints.Gets.tvDetail.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: TVDetailResponse.self){ response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure(let err):
                            observer.onError(err)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func getMovieList() -> Observable<MoviePopularResponse?> {
        return Observable<MoviePopularResponse?>.create{observer in
            if let url = URL(string: Endpoints.Gets.movieList.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MoviePopularResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure(let err):
                            observer.onError(err)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func getTVList() -> Observable<TVPopularResponse?> {
        return Observable<TVPopularResponse?>.create{ observer in
            if let url = URL(string: Endpoints.Gets.tvList.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: TVPopularResponse.self){ response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure(let err):
                            observer.onError(err)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    
    
    
    
}
