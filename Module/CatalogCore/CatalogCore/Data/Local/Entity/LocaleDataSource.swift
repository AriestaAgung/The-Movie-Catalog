//
//  LocalDataSource.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RealmSwift
import RxSwift
import CatalogCommon

public protocol LocaleDataSourceProtocol {
    func getTVList() -> Observable<[TVListEntity]>
    func addTVList(from list: [TVListEntity]) -> Observable<Bool>
    func getTVDetail(id: Int) -> Observable<TVListEntity>
    func addTVDetail(item: TVListEntity) -> Observable<Bool>
    
    // TV Favorite
    func getFavoriteTVList() -> Observable<[TVListEntity]>
    func getFavoriteTVDetail(id: Int) -> Observable<TVListEntity>
    func addTVFavorite(from list: [TVListEntity]) -> Observable<Bool>
    func addTVFavoriteDetail(item: TVListEntity) -> Observable<Bool>
    
    // Movie Favorite
    func getFavoriteMovieList() -> Observable<[MovieListEntity]>
    func getFavoriteMovieDetail(id: Int) -> Observable<MovieListEntity>
    func addMovieFavorite(from list: [MovieListEntity]) -> Observable<Bool>
    func addMovieFavoriteDetail(item: MovieListEntity) -> Observable<Bool>
    
    func getMovieList() -> Observable<[MovieListEntity]>
    func addMovieList(from list: [MovieListEntity]) -> Observable<Bool>
    func getMovieDetail(id: Int) -> Observable<MovieListEntity>
    func addMovieDetail(item: MovieListEntity) -> Observable<Bool>
    
}

public final class LocaleDataSource: NSObject {
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    public static let shared: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
    
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    public func addTVFavorite(from list: [TVListEntity]) -> Observable<Bool> {
        return Observable<Bool>.create{ observer in
            observer.onNext(false)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    public func addTVFavoriteDetail(item: TVListEntity) -> Observable<Bool> {
        return Observable<Bool>.create{ observer in
            if let realm = self.realm {
                do {
                    try realm.write{
                        item.isFavorite = !item.isFavorite
                        realm.add(item, update: .all)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch let err {
                    observer.onError(err)
                }
            }
            return Disposables.create()
        }
    }
    
    public func getFavoriteMovieList() -> Observable<[MovieListEntity]> {
        return Observable<[MovieListEntity]>.create{ observer in
            if let realm = self.realm {
                let movie: Results<MovieListEntity> = realm.objects(MovieListEntity.self)
                    
                observer.onNext(movie.filter{$0.isFavorite == true})
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    public func getFavoriteMovieDetail(id: Int) -> Observable<MovieListEntity> {
        return Observable<MovieListEntity>.create{ observer in
            if let realm = self.realm {
                let movie: Results<MovieListEntity> = realm.objects(MovieListEntity.self)
                observer.onNext(movie.filter{$0.id == id}.first!)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    public func addMovieFavorite(from list: [MovieListEntity]) -> Observable<Bool> {
        return Observable<Bool>.create{ observer in
            observer.onNext(false)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    public func addMovieFavoriteDetail(item: MovieListEntity) -> Observable<Bool> {
        return Observable<Bool>.create{ observer in
            if let realm = self.realm {
                do {
                    try realm.write{
                        item.isFavorite = !item.isFavorite
                        realm.add(item, update: .all)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch let err {
                    observer.onError(err)
                }
            }
            return Disposables.create()
        }
    }
    
    public func getFavoriteTVList() -> RxSwift.Observable<[TVListEntity]> {
        return Observable<[TVListEntity]>.create{ observer in
            if let realm = self.realm {
                let tv: Results<TVListEntity> = realm.objects(TVListEntity.self)
                observer.onNext(tv.filter{$0.isFavorite == true})
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    public func getFavoriteTVDetail(id: Int) -> Observable<TVListEntity> {
        return Observable<TVListEntity>.create{ observer in
            if let realm = self.realm {
                let tv: Results<TVListEntity> = realm.objects(TVListEntity.self)
                observer.onNext(tv.filter{$0.id == id}.first!)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    public func addTVDetail(item: TVListEntity) -> Observable<Bool> {
        return Observable<Bool>.create{ observer in
            if let realm = self.realm {
                do {
                    try realm.write{
                        realm.add(item, update: .all)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch(let err) {
                    observer.onError(err)
                }
            }
            return Disposables.create()
        }
    }
    
    public func addMovieDetail(item: MovieListEntity) -> Observable<Bool> {
        return Observable<Bool>.create{ observer in
            if let realm = self.realm {
                do {
                    try realm.write{
                        realm.add(item, update: .all)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch(let err) {
                    observer.onError(err)
                }
            }
            return Disposables.create()
        }
    }
    
    public func getMovieDetail(id: Int) -> Observable<MovieListEntity> {
        return Observable<MovieListEntity>.create{ observer in
            if let realm = self.realm {
                let movie: Results<MovieListEntity> = realm.objects(MovieListEntity.self)
                observer.onNext(movie.filter{$0.id == id}.first!)
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    public func getTVDetail(id: Int) -> Observable<TVListEntity> {
        return Observable<TVListEntity>.create{ observer in
            if let realm = self.realm {
                let tv: Results<TVListEntity> = realm.objects(TVListEntity.self)
                observer.onNext(tv.filter{$0.id == id}.first!)
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    public func getMovieList() -> Observable<[MovieListEntity]> {
        return Observable<[MovieListEntity]>.create{ observer in
            if let realm = self.realm {
                let movieList: Results<MovieListEntity> = {
                    realm.objects(MovieListEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(movieList.toArray(ofType: MovieListEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    public func addMovieList(from list: [MovieListEntity]) -> Observable<Bool> {
        return Observable<Bool>.create{ observer in
            if let realm = self.realm {
                do {
                    try realm.write{
                        for item in list {
                            realm.add(item, update: .all)
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch(let err) {
                    observer.onError(err)
                }
            }
            return Disposables.create()
        }
    }
    
    public func addTVList(from list: [TVListEntity]) -> Observable<Bool> {
        return Observable<Bool>.create{ observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for item in list {
                            realm.add(item, update: .all)
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch (let err) {
                    observer.onError(err)
                }
            }
            return Disposables.create()
        }
    }
    
    public func getTVList() -> Observable<[TVListEntity]> {
        return Observable<[TVListEntity]>.create{ observer in
            if let realm = self.realm {
                let tvList: Results<TVListEntity> = {
                    realm.objects(TVListEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(tvList.toArray(ofType: TVListEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    
}
