//
//  FavoriteRouter.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 10/01/23.
//

import Foundation
import SwiftUI
import RxSwift

class FavoriteRouter{
    func showDetailView(id: Int, isMovie: Bool) -> some View {
        let detailUseCase = Injection().provideDetailItem()
        let favoriteUseCase = Injection().provideFavorite()
        let presenter = DetailPresenter(useCase: detailUseCase, isMovie: isMovie, selectedID: id)
        let favoritePresenter = FavoritePresenter(useCase: favoriteUseCase)
        return MovieDetailView(presenter: presenter, favoritePresenter: favoritePresenter, isMovie: isMovie)
    }
}
