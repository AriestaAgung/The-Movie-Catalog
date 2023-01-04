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
    
    init(title: String? = nil, desc: String? = nil, rate: String? = nil, firstAiring: String? = nil, imageURL: String? = nil) {
        self.title = title
        self.desc = desc
        self.rate = rate
        self.firstAiring = firstAiring
        self.imageURL = imageURL
    }
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 8) {
            
            LazyHStack {
                WebImage(url: URL(string: imageURL ?? "" ))
                    .resizable()
                    .placeholder(Image("NoImage"))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40, alignment: .leading)
                
                Text(title ?? "Test")
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
            .padding(.leading, 8)
            .padding([.trailing], 16)
            
            
            Text(desc ?? "This is a description")
                .getCustomFont(type: .medium, size: 12)
                .lineLimit(2)
                .padding([.leading, .top, .trailing], 8)
                
        }
    }
}

struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeCell()
    }
}
