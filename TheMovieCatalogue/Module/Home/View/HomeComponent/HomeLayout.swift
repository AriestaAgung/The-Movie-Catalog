//
//  HomeLayout.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 22/12/22.
//

import SwiftUI

struct HomeLayout: View {
    @ObservedObject var presenter: HomePresenter
    var tvData: [TVListModel]
    var movieData: [MovieListModel]
    var isMovie: Bool
    var body: some View {
        List {
            if isMovie {
                ForEach(movieData, id: \.id) { item in
                    HomeCell(title: item.title, desc: item.desc, rate: item.id.description, firstAiring: item.firstAiring, imageURL: item.posterImage, isMovie: isMovie, presenter: presenter, id: item.id)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
                .padding(0)
            
            } else {
                ForEach(tvData, id: \.id) { item in
                    HomeCell(title: item.title, desc: item.desc, rate: item.id.description, firstAiring: item.firstAiring, imageURL: item.posterImage, isMovie: isMovie, presenter: presenter, id: item.id)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
                .padding(0)
            }
        }
    }
}

//struct HomeLayout_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeLayout(tvData: [TVListModel(id: 33, title: "TitleOnly", posterImage: "", desc: "Desc", firstAiring: "01-01-2021")], movieData: [], isMovie: true, presenter: nil)
//    }
//}
