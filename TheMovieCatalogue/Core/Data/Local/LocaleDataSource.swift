//
//  LocalDataSource.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleDataSourceProtocol {
    func getTVList() -> Observable<[TVListEntity]>
    func addTVList(from list: [TVListEntity]) -> Observable<Bool>
    func getTVDetail(id: Int) -> Observable<TVListEntity>
    func addTVDetail(item: TVListEntity) -> Observable<Bool>
    
    func getMovieList() -> Observable<[MovieListEntity]>
    func addMovieList(from list: [MovieListEntity]) -> Observable<Bool>
    func getMovieDetail(id: Int) -> Observable<MovieListEntity>
    func addMovieDetail(item: MovieListEntity) -> Observable<Bool>
    
}

final class LocaleDataSource: NSObject {
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let shared: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func addTVDetail(item: TVListEntity) -> Observable<Bool> {
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
    
    func addMovieDetail(item: MovieListEntity) -> Observable<Bool> {
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
    
    func getMovieDetail(id: Int) -> Observable<MovieListEntity> {
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
    
 
    
    func getTVDetail(id: Int) -> Observable<TVListEntity> {
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
    
    func getMovieList() -> Observable<[MovieListEntity]> {
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
    
    func addMovieList(from list: [MovieListEntity]) -> Observable<Bool> {
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
    
    func addTVList(from list: [TVListEntity]) -> Observable<Bool> {
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
    
    func getTVList() -> Observable<[TVListEntity]> {
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
