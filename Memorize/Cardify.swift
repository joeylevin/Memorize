//
//  Cardify.swift
//  Memorize
//
//  Created by joey levin on 2/11/25.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    init(isFaceUp: Bool, color: Color, symbol: String) {
        self.rotation = isFaceUp ? 0 : 180
        self.color = color
        self.symbol = symbol
    }
    var isFaceUp: Bool {
        rotation < 90
    }
    let color: Color
    let symbol: String
    
    var rotation: Double
    
    var animatableData: Double {
        get {rotation}
        set {rotation = newValue}
    }

    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(color))
                .overlay(backContent)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
    }
    
    private var backContent: some View {
        Image(systemName: symbol)
            .imageScale(.large)
            .font(.largeTitle)
            .padding(Constants.cardPadding)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let cardPadding: CGFloat = 5
    }
}

extension View {
    func cardify(isFaceUp: Bool, color: Color, symbol: String) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, color: color, symbol: symbol))
    }
}
