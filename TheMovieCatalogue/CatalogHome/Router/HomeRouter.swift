//
//  HomeRouter.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import SwiftUI
import RxSwift
import CatalogCore
import CatalogDetail

class HomeRouter{
    func showDetailView(id: Int, isMovie: Bool) -> some View {
        let detailUseCase = Injection().provideDetailItem()
        let favoriteUseCase = Injection().provideFavorite()
        let presenter = DetailPresenter(useCase: detailUseCase, favoriteUseCase: favoriteUseCase, isMovie: isMovie, selectedID: id)
        return MovieDetailView(presenter: presenter, isMovie: isMovie)
    }
}
