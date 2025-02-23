//
//  EmojiMemoryGame.swift
//  Memorize View Model
//
//  Created by joey levin on 2/5/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card

    init() {
        chosenTheme = ThemeChooser().themes.randomElement()!
        let emojis = chosenTheme.emojis.shuffled()
        print(emojis)
        let safeIndex = chosenTheme.numberOfCards ?? Int.random(in: 0..<chosenTheme.emojis.count)
        model = MemoryGame(numberOfPairsOfCards: safeIndex)
        { index in
            if emojis.indices.contains(index) {
                return emojis[index]
            } else {
                return "!?"
            }
        }
        model.shuffle()
    }
    
    private var chosenTheme: ThemeChooser.Theme
    @Published private var model : MemoryGame<String>
    
    var cards: Array<Card> {
        return model.cards
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    var theme: ThemeChooser.Theme {
        self.chosenTheme
    }
    
    var themeColor: Color {
        convertColor(color: chosenTheme.color)
    }
    
    var score: Int {
        model.score
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func convertColor(color: String) -> Color {
        switch color {
        case "orange": return .orange
        case "blue": return .blue
        case "red": return .red
        case "black": return .black
        case "green": return .green
        case "brown": return .brown
        default: return .black
        }
        
    }
    
    // MARK: - Intents
    
    func newGame() {
        chosenTheme = ThemeChooser().themes.randomElement()!
        let safeIndex = chosenTheme.numberOfCards ?? Int.random(in: 0..<chosenTheme.emojis.count)
        model = MemoryGame(numberOfPairsOfCards: safeIndex)
        { index in
            if theme.emojis.indices.contains(index) {
                return theme.emojis[index]
            } else {
                return "!?"
            }
        }
        model.shuffle()
    }
}
