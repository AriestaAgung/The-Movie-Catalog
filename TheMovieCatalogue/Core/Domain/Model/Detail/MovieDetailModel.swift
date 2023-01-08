//
//  MovieDetailModel.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 05/01/23.
//

import Foundation

struct MovieDetailModel: Equatable, Identifiable {
    let id: Int
    let title: String
    let posterImage: String
    let desc: String
    let firstAiring: String
}
