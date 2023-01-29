//
//  FavoriteRepository.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 08/01/23.
//

import Foundation
import RxSwift

protocol FavoriteRepositoryProtocol{
    func getTVFavoriteList() -> Observable<[TVListModel]>
    func getTVFavoriteDetail() -> Observable<TVListModel>
    func addTVFavoriteDetail(item: TVListEntity) -> Observable<Bool>
    
    func getMovieFavoriteList() -> Observable<[MovieListModel]>
    func getMovieFavoriteDetail() -> Observable<MovieListModel>
    func addMovieFavoriteDetail(item: MovieListEntity) -> Observable<Bool>

}

final class FavoriteRepository: NSObject {
    typealias TVInstance = (LocaleDataSource) -> FavoriteRepository
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource) {
        self.locale = locale
    }
    
    static let shared: TVInstance = { localeRepo in
        return FavoriteRepository(locale: localeRepo)
    }
}
//
//extension FavoriteRepository: FavoriteRepositoryProtocol {
//    func getTVFavoriteList() -> RxSwift.Observable<[TVListModel]> {
//        return self.locale.getFavoriteTVList()
//            .map{ HomeTVMapper.mapEntityToDomain(entities: $0)}
//            .filter{!$0.isEmpty}
//            
//    }
//    
//    func getTVFavoriteDetail() -> RxSwift.Observable<TVListModel> {
//        <#code#>
//    }
//    
//    func addTVFavoriteDetail(item: TVListEntity) -> RxSwift.Observable<Bool> {
//        <#code#>
//    }
//    
//    func getMovieFavoriteList() -> RxSwift.Observable<[MovieListModel]> {
//        <#code#>
//    }
//    
//    func getMovieFavoriteDetail() -> RxSwift.Observable<MovieListModel> {
//        <#code#>
//    }
//    
//    func addMovieFavoriteDetail(item: MovieListEntity) -> RxSwift.Observable<Bool> {
//        <#code#>
//    }
//    
//    
//}
