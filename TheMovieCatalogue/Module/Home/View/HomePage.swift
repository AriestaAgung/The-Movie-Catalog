//
//  HomePage.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 27/12/22.
//

import SwiftUI

struct HomePage: View {
    @State private var selectedTab: Int = 0
    let tabs: [Tab] = [
        .init(icon: Image(systemName: "music.note"), title: "Music"),
        .init(icon: Image(systemName: "film.fill"), title: "Movies"),
    ]
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color.black
                    .edgesIgnoringSafeArea([.all])
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        // Tabs
                        TabComponent(tabs: tabs, geoWidth: geo.size.width, selectedTab: $selectedTab)
                        // Views
                        TabView(selection: $selectedTab,
                                content: {
                            HomeLayout()
                                .tag(0)
                            HomeLayout()
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
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
