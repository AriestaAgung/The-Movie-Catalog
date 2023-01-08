//
//  Injection.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    private func provideTVRepository() -> TVRepositoryProtocol {
        let configuration = Realm.Configuration(
            schemaVersion: GeneralHelper.databaseSchemaVersion
        )
        let realm = try? Realm(configuration: configuration)
        
        let locale: LocaleDataSource = LocaleDataSource.shared(realm)
        let remote: RemoteDataSource = RemoteDataSource.shared
        
        return TVRepository.shared(locale, remote)
    }
    private func provideMovieRepository() -> MovieRepositoryProtocol {
        let configuration = Realm.Configuration(
            schemaVersion: GeneralHelper.databaseSchemaVersion
        )
        let realm = try? Realm(configuration: configuration)
        
        let locale: LocaleDataSource = LocaleDataSource.shared(realm)
        let remote: RemoteDataSource = RemoteDataSource.shared
        
        return MovieRepository.shared(locale, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repo = provideTVRepository()
        let movieRepo = provideMovieRepository()
        return HomeInteractor(TVRepository: repo, movieRepository: movieRepo)
    }
    
    func provideDetailItem() -> DetailUseCase {
        let repo = provideTVRepository()
        let movieRepo = provideMovieRepository()
        return DetailInteractor(TVRepository: repo, movieRepository: movieRepo)
    }
}
