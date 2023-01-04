//
//  TVEntity.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RealmSwift

class TVEntity: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var posterImage: String = ""
    @objc dynamic var desc: String = ""
    
    override static func primaryKey() -> String? {
      return "id"
    }
}
