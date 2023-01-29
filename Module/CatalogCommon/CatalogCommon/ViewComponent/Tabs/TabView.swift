//
//  TabView.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 27/12/22.
//

import SwiftUI

public struct Tab {
    public init(icon: Image?, title: String) {
        self.icon = icon
        self.title = title
    }
    public var icon: Image?
    public var title: String
}

public struct TabComponent: View {
    public var fixed = true
    public var tabs: [Tab]
    public var geoWidth: CGFloat
    @Binding public var selectedTab: Int
    public init(fixed: Bool = true, tabs: [Tab], geoWidth: CGFloat, selectedTab: Binding<Int>) {
        self.fixed = fixed
        self.tabs = tabs
        self.geoWidth = geoWidth
        self._selectedTab = selectedTab
    }
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< tabs.count, id: \.self) { row in
                            Button(action: {
                                withAnimation {
                                    selectedTab = row
                                }
                            }, label: {
                                VStack(spacing: 0) {
                                    HStack {
                                        // Image
                                        AnyView(tabs[row].icon)
                                            .foregroundColor(.white)
                                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                                        // Text
                                        Text(tabs[row].title)
                                            .font(Font.system(size: 18, weight: .semibold))
                                            .foregroundColor(Color.white)
                                            .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 15))
                                    }
                                    .frame(width: fixed ? (geoWidth / CGFloat(tabs.count)) : .none, height: 52)
                                    // Bar Indicator
                                    Rectangle().fill(selectedTab == row ? Color.white : Color.clear)
                                        .frame(height: 3)
                                }.fixedSize()
                            })
                            .accentColor(Color.white)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onChange(of: selectedTab) { target in
                        withAnimation {
                            proxy.scrollTo(target)
                        }
                    }
                }
            }
        }
        .frame(height: 55)
        .onAppear(perform: {
            UIScrollView.appearance().backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))
            UIScrollView.appearance().bounces = fixed ? false : true
        })
        .onDisappear(perform: {
            UIScrollView.appearance().bounces = true
        })
    }
}

//struct TabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabComponent(fixed: true,
//                     tabs: [.init(icon: Image(systemName: "star.fill"), title: "Tab 1"),
//                            .init(icon: Image(systemName: "star.fill"), title: "Tab 2"),
//                            .init(icon: Image(systemName: "star.fill"), title: "Tab 3")],
//                     geoWidth: 375,
//                     selectedTab: .constant(0))
//    }
//}
