//
//  EmojiMemoryGameView.swift
//  Memorize View
//
//  Created by joey levin on 2/2/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            Text("Memorize: \(viewModel.theme.name)").font(.largeTitle)
            cards
            .animation(.default, value: viewModel.cards)
            Spacer()
            HStack {
                Button("New Game") {
                    viewModel.newGame()
                }
                Spacer()
                Text("\(viewModel.score)")
            }
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card: card, symbol: viewModel.theme.symbol, color: viewModel.themeColor)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
