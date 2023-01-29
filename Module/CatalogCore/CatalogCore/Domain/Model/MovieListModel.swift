//
//  MovieListModel.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 05/01/23.
//

import Foundation

public struct MovieListModel: Equatable, Identifiable {
    public let id: Int
    public let title: String
    public let posterImage: String
    public let desc: String
    public let firstAiring: String
    public let isFavorite: Bool
}
