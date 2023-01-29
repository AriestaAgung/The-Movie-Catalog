//
//  TheMovieCatalogueApp.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 22/12/22.
//

import SwiftUI
import CatalogCore
import CatalogCommon

@main
struct TheMovieCatalogueApp: App {
    init() {
        GeneralHelper.getInfo(bundle: Bundle.main)
    }
    var body: some Scene {
        WindowGroup {
            HomePage()            
        }
    }
}
