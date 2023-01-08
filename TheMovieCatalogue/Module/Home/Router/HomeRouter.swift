//
//  HomeRouter.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import SwiftUI
import RxSwift

class HomeRouter{
    func showDetailView(id: Int, isMovie: Bool) -> some View {
        let detailUseCase = Injection().provideDetailItem()
        let presenter = DetailPresenter(useCase: detailUseCase, isMovie: isMovie, selectedID: id)
        return MovieDetailView(presenter: presenter, isMovie: isMovie)
    }
}
