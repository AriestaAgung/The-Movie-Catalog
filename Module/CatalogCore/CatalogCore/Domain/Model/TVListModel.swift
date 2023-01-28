//
//  TVListModel.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation

public struct TVListModel: Equatable, Identifiable {
    let id: Int
    let title: String
    let posterImage: String
    let desc: String
    let firstAiring: String
    let isFavorite: Bool
}
