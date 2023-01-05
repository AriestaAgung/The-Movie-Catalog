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
        HStack(spacing: 8){
            WebImage(url: URL(string: imageURL ?? "" ))
                .resizable()
                .placeholder(Image("NoImage"))
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 64)
            LazyVStack(alignment: .leading, spacing: 8) {
                Text(title ?? "Test")
                    .getCustomFont(type: .bold, size: 16)
                Text(firstAiring ?? "First Air Date")
                    .getCustomFont(type: .regular, size: 10)
                    .padding(.trailing, 16)
                
                if desc != "" {
                    Text(desc ?? "")
                        .getCustomFont(type: .medium, size: 12)
                        .lineLimit(2)
                        .padding([.trailing], 8)
                } else {
                    Text(title ?? "")
                        .getCustomFont(type: .medium, size: 12)
                        .lineLimit(2)
                        .padding([.trailing], 8)
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: 160, alignment: .leading)
        
    }
}

struct HomeCell_Previews: PreviewProvider {
    static var previews: some View {
        HomeCell()
    }
}
