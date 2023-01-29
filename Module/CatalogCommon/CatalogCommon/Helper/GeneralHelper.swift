//
//  GeneralHelper.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 22/12/22.
//

import Foundation
import SwiftUI

public final class GeneralHelper {
    public static var databaseSchemaVersion: UInt64 = 1
    
    public static func getCustomPath(id: String, baseEndpoint: String) -> URL? {
        let combined = baseEndpoint + id + "?api_key=" + API.apiKey
        return URL(string: combined)
    }
    public static func getInfo(bundle: Bundle) {
        UIFont.jbs_registerFont(withFilenameString: "Font/Montserrat-Bold", bundle: bundle)
        UIFont.jbs_registerFont(withFilenameString: "Font/Montserrat-SemiBold", bundle: bundle)
        UIFont.jbs_registerFont(withFilenameString: "Font/Montserrat-Regular", bundle: bundle)
        UIFont.jbs_registerFont(withFilenameString: "Font/Montserrat-Medium", bundle: bundle)
    }
//    static public func loadFont() {
//        if let fontUrl = Bundle(for: GeneralHelper.self).url(forResource: "Font/Montserrat-Bold", withExtension: "ttf"),
//           let dataProvider = CGDataProvider(url: fontUrl as CFURL),
//           let newFont = CGFont(dataProvider) {
//            var error: Unmanaged<CFError>?
//            if !CTFontManagerRegisterGraphicsFont(newFont, &error)
//            {
//                print("Error loading Font!")
//            } else {
//                print("Loaded font")
//            }
//        } else {
//            assertionFailure("Error loading font")
//        }
//    }
    
}
