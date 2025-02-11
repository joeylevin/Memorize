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
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            
            Group {
                base.fill(.white)
                Pie(endAngle: .degrees(240))
                    .opacity(Constants.pie.opacity)
                    .overlay(
                        Text(card.content)
                            .font(.system(size: Constants.FontSize.largest))
                            .minimumScaleFactor(Constants.FontSize.scaleFactor)
                            .multilineTextAlignment(.center)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(Constants.pie.inset)
                    )
                    .padding(Constants.inset)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            Group {
                base.fill(color)
                Image(systemName: symbol)
                    .imageScale(.large)
                    .font(.largeTitle)
            }
            .opacity(card.isFaceUp ? 0 : 1)
            
            base.strokeBorder(lineWidth: Constants.lineWidth)
        }
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
