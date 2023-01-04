//
//  TheMovieCatalogueApp.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 22/12/22.
//

import SwiftUI

@main
struct TheMovieCatalogueApp: App {
    var body: some Scene {
        WindowGroup {
            let homeUseCase = Injection().provideHome()
            let homePresenter = HomePresenter(useCase: homeUseCase)
            HomePage(presenter: homePresenter)
        }
    }
}
