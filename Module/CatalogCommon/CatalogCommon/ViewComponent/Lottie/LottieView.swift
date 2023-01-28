//
//  LottieBuilder.swift
//  TheMovieCatalogue
//
//  Created by BRIMO on 06/01/23.
//

import Foundation
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let file: String
    
    func makeUIView(context: Context) -> some UIView {
        let animationView = LottieAnimationView(name: file)
        let view = UIView(frame: .zero)
        
        animationView.play()
        
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        return view
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}
