//
//  HomeTabView.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 05/01/23.
//

import SwiftUI

struct HomeTabView: View {
    @State private var selectedTab: Int = 0
    @ObservedObject var presenter: HomePresenter
    let tabs: [Tab] = [
        .init(icon: Image(systemName: "film.fill"), title: "Movies"),
        .init(icon: Image(systemName: "sparkles.tv.fill"), title: "TV Series"),
    ]
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
                            HomeLayout(presenter: presenter, tvData: presenter.tvList, movieData: presenter.movieList, isMovie: true)
                                .tag(0)
                            HomeLayout(presenter: presenter, tvData: presenter.tvList, movieData: presenter.movieList, isMovie: false)
                                .tag(1)
                        })
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                }
            }
            .modifier(CustomNavigationView())
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
        .onAppear{
            if self.presenter.tvList.count == 0 {
                self.presenter.getTVList()
            }
            if self.presenter.movieList.count == 0 {
                self.presenter.getMovieList()
            }

        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        let homeUseCase = Injection().provideHome()
        let homePresenter = HomePresenter(useCase: homeUseCase)
        HomeTabView(presenter: homePresenter)
    }
}
