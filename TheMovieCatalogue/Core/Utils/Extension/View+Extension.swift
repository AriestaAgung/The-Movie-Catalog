//
//  View+Extension.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 06/01/23.
//

import Foundation
import SwiftUI

extension View {
    func printLog(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
    
    func closureAction(completion: @escaping () -> ()) -> some View {
        completion()
        return EmptyView()
    }
}
