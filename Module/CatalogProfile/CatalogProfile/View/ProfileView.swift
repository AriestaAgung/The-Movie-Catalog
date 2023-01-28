//
//  ProfileView.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 05/01/23.
//

import SwiftUI

public struct ProfileView: View {
    var body: some View {
        NavigationView{
            ZStack{
                GeometryReader { geo in
                    VStack(spacing: 16) {
                        Image("profileImage")
                        Text("Ariesta Agung")
                            .getCustomFont(type: .bold, size: 32)
                        Text("ariesta.app@devatacreative.com")
                            .getCustomFont(type: .semiBold, size: 16)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            
            .modifier(CustomNavigationView())
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
       
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
