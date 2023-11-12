//
//  LottieView.swift
//  Poof
//
//  Created by Jonathan Evan Christian on 12/10/23.
//

import SwiftUI
import Lottie

struct LottieViewComponent: UIViewRepresentable {
        
    let name: String
    let loopMode: LottieLoopMode
    
    func makeUIView(context: UIViewRepresentableContext<LottieViewComponent>) -> UIView {
        
        let view = UIView()
        
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        return view
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieViewComponent>) {}
}
