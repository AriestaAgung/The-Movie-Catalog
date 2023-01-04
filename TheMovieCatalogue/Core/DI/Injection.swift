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
        let realm = try? Realm()
        
        let locale: LocaleDataSource = LocaleDataSource.shared(realm)
        let remote: RemoteDataSource = RemoteDataSource.shared
        
        return TVRepository.shared(locale, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repo = provideRepository()
        return HomeInteractor(TVRepository: repo)
    }
}
