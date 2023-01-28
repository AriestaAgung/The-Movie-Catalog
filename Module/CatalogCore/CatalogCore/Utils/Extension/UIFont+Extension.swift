//
//  UIFont+Extension.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 03/01/23.
//

import Foundation
import UIKit

public extension UIFont {
    static func getCustomFont(type: FontType, size: CGFloat = 14) -> UIFont {
        
        return UIFont(name: type.rawValue, size: size)!
    }
}
