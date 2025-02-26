//
//  CardView.swift
//  Memorize
//
//  Created by joey levin on 2/11/25.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: Card
    let symbol: String
    let color: Color
    
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(Constants.pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.pie.inset)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(.spin(duration: 1), value: card.isMatched)
            )
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp, color: color, symbol: symbol )
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
            .accessibilityLabel(card.content) // Optional: Add accessibility for visually impaired users
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct pie {
            static let opacity: CGFloat = 0.4
            static let inset: CGFloat = 5
        }
    }
    
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: duration).repeatForever(autoreverses: false)
    }
}

#Preview {
    HStack {
        CardView(card: CardView.Card(content: "X", id: "test1"), symbol: "carrot", color: .blue)
            .padding()
        CardView(card: CardView.Card(isFaceUp: true, content: "Y", id: "test2"), symbol: "car", color: .blue)
            .padding()
    }
    HStack {
        CardView(card: CardView.Card(isFaceUp: false, isMatched: true, content: "X", id: "test1"), symbol: "carrot", color: .blue)
            .padding()
        CardView(card: CardView.Card(isFaceUp: true,  isMatched: true, content: "Y", id: "test2"), symbol: "car", color: .blue)
            .padding()
    }
}
