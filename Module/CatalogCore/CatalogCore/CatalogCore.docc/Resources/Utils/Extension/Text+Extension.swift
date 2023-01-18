//
//  Text+Extension.swift
//  
//
//  Created by BRIMO on 18/01/23.
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
