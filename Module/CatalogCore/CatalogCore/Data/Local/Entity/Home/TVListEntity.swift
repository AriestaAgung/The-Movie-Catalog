//
//  TVListEntity.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RealmSwift

public class TVListEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var posterImage: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var firstAiring: String = ""
    @objc dynamic var isFavorite: Bool = false
    
    override static func primaryKey() -> String? {
      return "id"
    }
}
