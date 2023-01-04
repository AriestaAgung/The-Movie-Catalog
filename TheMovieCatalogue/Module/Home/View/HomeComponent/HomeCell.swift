//
//  HomeCell.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 22/12/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeCell: View {
    var title: String?
    var desc: String?
    var rate: String?
    var firstAiring: String?
    var imageURL: String?
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 8) {
            
            LazyHStack {
                WebImage(url: URL(string: imageURL ?? "" ))
                    .resizable()
                    .placeholder(Image("NoImage"))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40, alignment: .leading)
                
                Text("TESTING NGAB")
                    .getCustomFont(type: .medium, size: 16)
                
            }
            LazyHStack{
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.gray)
                Text(rate ?? "0")
                    .getCustomFont(type: .medium, size: 12)
                Text(" || ")
                    .getCustomFont(type: .medium, size: 12)
                Text(firstAiring ?? "First Air Date")
                    .getCustomFont(type: .medium, size: 12)
            }
            .padding([.leading], 48)
            
            Text(desc ?? "This is a description")
                .getCustomFont(type: .medium, size: 12)
                .lineLimit(2)
                .padding([.leading, .top], 8)
                
        }
    }
}

struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeCell()
    }
}
