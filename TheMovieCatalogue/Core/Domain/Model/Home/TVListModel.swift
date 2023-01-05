//
//  TVListModel.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation

struct TVListModel: Equatable, Identifiable {
    let id: String
    let title: String
    let posterImage: String
    let desc: String
    let firstAiring: String
}
