//
//  FavoriteLayout.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 10/01/23.
//

import Foundation
import SwiftUI
import CatalogCore

struct FavoriteLayout: View {
    
    @ObservedObject var presenter: FavoritePresenter
    @State var tvData: [TVListModel]
    @State var movieData: [MovieListModel]
    var isMovie: Bool
    var isFavorite: Bool = false
    init(presenter: FavoritePresenter, tvData: [TVListModel], movieData: [MovieListModel], isMovie: Bool, isFavorite: Bool) {
        self.presenter = presenter
        self.tvData = tvData
        self.movieData = movieData
        self.isMovie = isMovie
        self.isFavorite = isFavorite
    }
    var body: some View {
        List {
            if isMovie {
                ForEach(movieData
                    .filter{$0.isFavorite == true},
                        id: \.id)
                { item in
                    FavoriteCell(title: item.title, desc: item.desc, rate: item.id.description, firstAiring: item.firstAiring, imageURL: item.posterImage, isMovie: isMovie, presenter: presenter, id: item.id)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
                .padding(0)
            } else {
                ForEach(tvData
                    .filter{$0.isFavorite == true},
                        id: \.id)
                { item in
                    FavoriteCell(title: item.title, desc: item.desc, rate: item.id.description, firstAiring: item.firstAiring, imageURL: item.posterImage, isMovie: isMovie, presenter: presenter, id: item.id)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
                .padding(0)
            }
        }
        .onAppear{
            if isMovie {
                self.presenter.getMovieList()
                self.movieData = self.$presenter.movieList.wrappedValue
            } else {
                self.presenter.getTVList()
                self.tvData = self.presenter.tvList
                dump(tvData)
            }
        }
    }
}
