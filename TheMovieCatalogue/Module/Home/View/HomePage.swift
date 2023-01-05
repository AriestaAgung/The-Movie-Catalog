//
//  HomePage.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 27/12/22.
//

import SwiftUI

struct HomePage: View {
    @State private var selectedTab: Int = 0
    @ObservedObject var presenter: HomePresenter
    let tabs: [Tab] = [
        .init(icon: Image(systemName: "film.fill"), title: "Movies"),
        .init(icon: Image(systemName: "sparkles.tv.fill"), title: "TV Series"),
    ]
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black
                    .edgesIgnoringSafeArea([.top])
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        // Tabs
                        TabComponent(tabs: tabs, geoWidth: geo.size.width, selectedTab: $selectedTab)
                        // Views
                        TabView(selection: $selectedTab,
                                content: {
                            HomeLayout(tvData: presenter.tvList)
                                .tag(0)
                            HomeLayout(tvData: presenter.tvList)
                                .tag(1)
                        })
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                }
            }
            .onAppear{
                if self.presenter.tvList.count == 0 {
                    self.presenter.getTVList()
                }
            }
            .modifier(CustomNavigationView())
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        let homeUseCase = Injection().provideHome()
        let homePresenter = HomePresenter(useCase: homeUseCase)
        HomePage(presenter: homePresenter)
    }
}
