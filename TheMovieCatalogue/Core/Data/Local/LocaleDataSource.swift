//
//  LocalDataSource.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleDataSourceProtocol: class {
    func getTVList() -> Observable<[TVEntity]>
    func addTVList(from list: [TVEntity]) -> Observable<Bool>
//    func getTVByID() ->
    
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
    func addTVList(from list: [TVEntity]) -> Observable<Bool> {
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
    
    func getTVList() -> Observable<[TVEntity]> {
        return Observable<[TVEntity]>.create{ observer in
            if let realm = self.realm {
                let tvList: Results<TVEntity> = {
                    realm.objects(TVEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(tvList.toArray(ofType: TVEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    
}
