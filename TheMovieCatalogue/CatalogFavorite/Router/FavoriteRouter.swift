//
//  FavoriteRouter.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 10/01/23.
//

import Foundation
import SwiftUI
import RxSwift
import CatalogCore
import CatalogDetail

class FavoriteRouter{
    init() {}
    func showDetailView(id: Int, isMovie: Bool) -> some View {
        let detailUseCase = Injection().provideDetailItem()
        let favoriteUseCase = Injection().provideFavorite()
        let presenter = DetailPresenter(useCase: detailUseCase, favoriteUseCase: favoriteUseCase, isMovie: isMovie, selectedID: id)
        return MovieDetailView(presenter: presenter, isMovie: isMovie)
    }
}
