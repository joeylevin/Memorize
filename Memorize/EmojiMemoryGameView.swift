//
//  EmojiMemoryGameView.swift
//  Memorize View
//
//  Created by joey levin on 2/2/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            Text("Memorize: \(viewModel.theme.name)").font(.largeTitle)
            cards
            Spacer()
            HStack {
                newGame
                Spacer()
                shuffle
                Spacer()
                score
            }
        }
        .padding()
    }
    
    private var score: some View {
        Text("\(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation() {
                viewModel.shuffle()
            }
        }
    }
    
    private var newGame: some View {
        Button("New Game") {
            viewModel.newGame()
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card: card, symbol: viewModel.theme.symbol, color: viewModel.themeColor)
                .padding(spacing)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation() {
                        viewModel.choose(card)
                    }
                }
        }
    }
    private func scoreChange(causedBy card: Card) -> Int {
        return 0
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
