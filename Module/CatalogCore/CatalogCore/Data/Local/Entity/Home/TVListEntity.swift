//
//  TVListEntity.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 04/01/23.
//

import Foundation
import RealmSwift

public class TVListEntity: Object {
    @objc public dynamic var id: Int = 0
    @objc public dynamic var title: String = ""
    @objc public dynamic var posterImage: String = ""
    @objc public dynamic var desc: String = ""
    @objc public dynamic var firstAiring: String = ""
    @objc public dynamic var isFavorite: Bool = false
    
    public override static func primaryKey() -> String? {
      return "id"
    }
}
