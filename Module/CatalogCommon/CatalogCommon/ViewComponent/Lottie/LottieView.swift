//
//  LottieBuilder.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 06/01/23.
//

import Foundation
import SwiftUI
import Lottie

public struct LottieView: UIViewRepresentable {
    public init(file: String) {
        self.file = file
    }
    let file: String
    public func makeUIView(context: Context) -> some UIView {
        let animationView = LottieAnimationView(name: file)
        let view = UIView(frame: .zero)
        
        animationView.play()
        
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        return view
        
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}
