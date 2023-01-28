//
//  TheMovieCatalogueApp.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 22/12/22.
//

import SwiftUI
import CatalogHome
import CatalogCore

@main
struct TheMovieCatalogueApp: App {
    
    init() {
        let injection = Injection()
        
    }
    var body: some Scene {
        WindowGroup {
            HomePage()
        }
    }
}
