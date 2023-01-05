//
//  HomePage.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 27/12/22.
//

import SwiftUI

struct HomePage: View {
    //    @State private var selectedTab: Int = 0
    //    @ObservedObject var presenter: HomePresenter
    //    let tabs: [Tab] = [
    //        .init(icon: Image(systemName: "film.fill"), title: "Movies"),
    //        .init(icon: Image(systemName: "sparkles.tv.fill"), title: "TV Series"),
    //    ]
    @State private var selectedTabName = "Home"
    @State private var selection = 0
    var body: some View {
        TabView(selection: $selection) {
            let homeUseCase = Injection().provideHome()
            let homePresenter = HomePresenter(useCase: homeUseCase)
            HomeTabView(presenter: homePresenter)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
                .onAppear{
                    selectedTabName = "Home"
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(1)
                .onAppear{
                    selectedTabName = "Profile"
                }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        let homeUseCase = Injection().provideHome()
        let homePresenter = HomePresenter(useCase: homeUseCase)
        HomePage()
    }
}
