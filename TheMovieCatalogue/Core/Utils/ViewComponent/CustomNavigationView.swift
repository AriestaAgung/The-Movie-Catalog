//
//  CustomNavigationView.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 27/12/22.
//

import SwiftUI

struct CustomNavigationView: ViewModifier {


    init() {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1))
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
//        UINavigationBar.appearance().isTranslucent = false
        // this is not the same as manipulating the proxy directly
        let appearance = UINavigationBarAppearance()
        
        // this overrides everything you have set up earlier.
        appearance.configureWithTransparentBackground()
        
        // this only applies to big titles
        appearance.largeTitleTextAttributes = [
            .font : UIFont.getCustomFont(type: .bold, size: 20),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        // this only applies to small titles
        appearance.titleTextAttributes = [
            .font : UIFont.getCustomFont(type: .bold, size: 20),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
        //In the following two lines you make sure that you apply the style for good
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
        // This property is not present on the UINavigationBarAppearance
        // object for some reason and you have to leave it til the end
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 0.5))
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white, .font: FontType.bold.rawValue]
        UINavigationBar.appearance().isTranslucent = true
    }
    func body(content: Content) -> some View {
        content
    }
}
