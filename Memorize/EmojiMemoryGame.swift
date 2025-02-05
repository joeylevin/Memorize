//
//  EmojiMemoryGame.swift
//  Memorize View Model
//
//  Created by joey levin on 2/5/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 4)
            { index in
                if emojis.indices.contains(index) {
                    return emojis[index]
                } else {
                    return "!?"
                }
            }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
}
