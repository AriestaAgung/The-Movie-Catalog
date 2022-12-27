//
//  HomeLayout.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 22/12/22.
//

import SwiftUI

struct HomeLayout: View {
    var body: some View {
        List {
            ForEach(Range(NSRange(location: 1, length: 10))!) {_ in
                HomeCell()
                    .listRowSeparator(.hidden)
            }
        }
        
        
    }
}

struct HomeLayout_Previews: PreviewProvider {
    static var previews: some View {
        HomeLayout()
    }
}
