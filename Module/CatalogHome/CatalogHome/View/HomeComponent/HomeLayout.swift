//
//  HomeLayout.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 22/12/22.
//

import SwiftUI

public struct HomeLayout: View {
    @ObservedObject var presenter: HomePresenter
    @State var tvData: [TVListModel]
    @State var movieData: [MovieListModel]
    var isMovie: Bool
    var isFavorite: Bool = false
    var body: some View {
        List {
            if isMovie {
                if !isFavorite {
                    ForEach(movieData, id: \.id) { item in
                        HomeCell(title: item.title, desc: item.desc, rate: item.id.description, firstAiring: item.firstAiring, imageURL: item.posterImage, isMovie: isMovie, presenter: presenter, id: item.id)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                    .padding(0)
                } else {
                    ForEach(movieData
                        .filter{$0.isFavorite == true},
                            id: \.id)
                    { item in
                        HomeCell(title: item.title, desc: item.desc, rate: item.id.description, firstAiring: item.firstAiring, imageURL: item.posterImage, isMovie: isMovie, presenter: presenter, id: item.id)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                    .padding(0)
                }
            
            } else {
                if !isFavorite {
                    ForEach(tvData, id: \.id) { item in
                        HomeCell(title: item.title, desc: item.desc, rate: item.id.description, firstAiring: item.firstAiring, imageURL: item.posterImage, isMovie: isMovie, presenter: presenter, id: item.id)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                    .padding(0)
                } else {
                    ForEach(tvData
                        .filter{$0.isFavorite == true},
                            id: \.id)
                    { item in
                        HomeCell(title: item.title, desc: item.desc, rate: item.id.description, firstAiring: item.firstAiring, imageURL: item.posterImage, isMovie: isMovie, presenter: presenter, id: item.id)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                    .padding(0)
                }
                
            }
        }
        .refreshable {
            if isMovie {
                self.presenter.getMovieList()
                self.movieData = presenter.movieList
            } else {
                self.presenter.getTVList()
                self.tvData = presenter.tvList
            }
        }
    }
}

//struct HomeLayout_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeLayout(tvData: [TVListModel(id: 33, title: "TitleOnly", posterImage: "", desc: "Desc", firstAiring: "01-01-2021")], movieData: [], isMovie: true, presenter: nil)
//    }
//}
