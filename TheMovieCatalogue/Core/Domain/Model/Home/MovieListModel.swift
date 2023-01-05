//
//  MovieListModel.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 05/01/23.
//

import Foundation

struct MovieListModel: Equatable, Identifiable {
    let id: String
    let title: String
    let posterImage: String
    let desc: String
    let firstAiring: String
}
