//
//  FavoriteCell.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 10/01/23.
//

import Foundation
import SDWebImageSwiftUI
import SwiftUI

struct FavoriteCell: View {
    @ObservedObject var presenter: FavoritePresenter
    public var title: String?
    public var desc: String?
    public var rate: String?
    public var firstAiring: String?
    public var imageURL: String?
    public var id: Int
    public var isMovie: Bool
    
    init(title: String? = nil, desc: String? = nil, rate: String? = nil, firstAiring: String? = nil, imageURL: String? = nil, isMovie: Bool = false, presenter: FavoritePresenter, id: Int) {
        self.title = title
        self.desc = desc
        self.rate = rate
        self.firstAiring = firstAiring
        self.imageURL = imageURL
        self.isMovie = isMovie
        self.presenter = presenter
        self.id = id
    }
    
    var body: some View {
        self.presenter.linkBuilder(isMovie: self.isMovie, id: self.id, content: {
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
        })
    }
}
