//
//  Font+Extension.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 22/12/22.
//

import Foundation
import SwiftUI

enum FontType: String {
    case regular = "Montserrat-Regular"
    case medium = "Montserrat-Medium"
    case semiBold = "Montserrat-SemiBold"
    case bold = "Montserrat-Bold"
}


extension Text {

    func getCustomFont(type: FontType, size: CGFloat) -> Text {
        return self.font(.custom(type.rawValue, size: size))
        
    }
}
