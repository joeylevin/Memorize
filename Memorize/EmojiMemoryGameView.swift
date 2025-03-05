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
                deck
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
        AspectVGrid(viewModel.cards, aspectRatio: Constants.aspectRatio) { card in
            if isDealt(card) {
                CardView(card: card, symbol: viewModel.theme.symbol, color: viewModel.themeColor)
                    .padding(Constants.spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0)
                    .onTapGesture {
                        choose(card)
                    }
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0)}
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card: card, symbol: viewModel.theme.symbol, color: viewModel.themeColor)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: Constants.deckWidth, height: Constants.deckWidth / Constants.aspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(Constants.dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay+=Constants.dealInterval
        }
    }
    
    private func choose(_ card: Card) {
        withAnimation() {
            let scoreBeforeChosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, causedByCardId: id) = lastScoreChange
        return card.id == id ? amount : 0 
    }
    
    private struct Constants {
        static let aspectRatio: CGFloat = 2/3
        static let spacing: CGFloat = 4
        static let deckWidth: CGFloat = 50
        static let dealInterval: TimeInterval = 0.1
        static let dealAnimation: Animation = .easeInOut(duration: 1)
        
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
