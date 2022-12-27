//
//  HomeCell.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 22/12/22.
//

import SwiftUI

struct HomeCell: View {
    var body: some View {
        LazyHStack {
            Image("NoImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40, alignment: .leading)
            Text("Testing ngab")
                .getCustomFont(type: .medium, size: 16)
        }
    }
}

struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeCell()
    }
}
