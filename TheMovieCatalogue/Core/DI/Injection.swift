//
//  Injection.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    private func provideRepository() -> TVRepositoryProtocol {
        let configuration = Realm.Configuration(
            schemaVersion: GeneralHelper.databaseSchemaVersion
        )
        let realm = try? Realm(configuration: configuration)
        
        let locale: LocaleDataSource = LocaleDataSource.shared(realm)
        let remote: RemoteDataSource = RemoteDataSource.shared
        
        return TVRepository.shared(locale, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repo = provideRepository()
        return HomeInteractor(TVRepository: repo)
    }
}
