//
//  GeneralHelper.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 22/12/22.
//

import Foundation
import SwiftUI

final class GeneralHelper {
    static var databaseSchemaVersion: UInt64 = 1
    
    static func getCustomPath(id: String, baseEndpoint: String) -> URL? {
        let combined = baseEndpoint + id + "?api_key=" + API.apiKey
        return URL(string: combined)
    }
}
