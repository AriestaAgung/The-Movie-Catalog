//
//  FavoriteLayout.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 08/01/23.
//

import SwiftUI
import CatalogCommon
import CatalogCore

struct FavoriteTabView: View {
    @State public var selectedTab: Int = 0
    @ObservedObject var presenter: FavoritePresenter
    let tabs: [Tab] = [
        .init(icon: Image(systemName: "film.fill"), title: "Movies"),
        .init(icon: Image(systemName: "sparkles.tv.fill"), title: "TV Series"),
    ]
    init(presenter: FavoritePresenter) {
        self.presenter = presenter
    }
    var body: some View {
        
        NavigationStack{
            ZStack{
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        // Tabs
                        TabComponent(tabs: tabs, geoWidth: geo.size.width, selectedTab: $selectedTab)
                        // Views
                        TabView(selection: $selectedTab,
                                content: {
                            ForEach(presenter.movieList) { tab in
                                /*@START_MENU_TOKEN@*/Text(tab.title)/*@END_MENU_TOKEN@*/
                            }
                            if presenter.movieList.filter{item in item.isFavorite}.count < 1 {
                                Text("No Item")
                                    .foregroundColor(Color.black)
                                    .tag(0)
                            } else {
                                FavoriteLayout(presenter: presenter, tvData: presenter.tvList, movieData: presenter.movieList, isMovie: true, isFavorite: true)
                                    .tag(0)
                            }
                            if presenter.tvList.filter{item in item.isFavorite}.count < 1 {
                                Text("No Item")
                                    .foregroundColor(Color.black)
                                    .tag(1)
                            } else {
                                FavoriteLayout(presenter: presenter, tvData: presenter.tvList, movieData: presenter.movieList, isMovie: false, isFavorite: true)
                                    .tag(1)
                            }
                        })
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                }
            }
            .modifier(CustomNavigationView())
            .navigationTitle("Favorite")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
        .onAppear{
            dump(presenter.movieList)
//            if self.presenter.tvList.count == 0 {
                self.presenter.getTVList()
//            }
//            if self.presenter.movieList.count == 0 {
                self.presenter.getMovieList()
//            }

        }
    }
}

struct FavoriteTabView_Previews: PreviewProvider {
    static var previews: some View {
        let homeUseCase = Injection().provideFavorite()
        let homePresenter = FavoritePresenter(useCase: homeUseCase)
        FavoriteTabView(presenter: homePresenter)
    }
}
