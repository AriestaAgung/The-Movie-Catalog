//
//  MovieListEntity.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 05/01/23.
//

import Foundation
import RealmSwift

class MovieListEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var posterImage: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var firstAiring: String = ""
    
    override static func primaryKey() -> String? {
      return "id"
    }
}
