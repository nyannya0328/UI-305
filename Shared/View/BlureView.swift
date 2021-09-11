//
//  BlureView.swift
//  BlureView
//
//  Created by nyannyan0328 on 2021/09/11.
//

import SwiftUI

struct BlureView: UIViewRepresentable {
    var style : UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
        
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

