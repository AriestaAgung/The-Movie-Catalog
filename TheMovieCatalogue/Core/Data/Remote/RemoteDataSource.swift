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
    func getTVList() -> Observable<TVPopularResponse?> {
        dump(API.imgBaseUrl)
        return Observable<TVPopularResponse?>.create{ observer in
            if let url = URL(string: Endpoints.Gets.tvList.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: TVPopularResponse.self){ response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                            dump(response.result)
                        case .failure(let err):
                            observer.onError(err)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    
    
    
}
