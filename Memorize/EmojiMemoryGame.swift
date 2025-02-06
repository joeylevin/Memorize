//
//  EmojiMemoryGame.swift
//  Memorize View Model
//
//  Created by joey levin on 2/5/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    init() {
        theme = ThemeChooser().themes.randomElement()!
        let emojis = theme.emojis.shuffled()
        print(emojis)
        model = MemoryGame(numberOfPairsOfCards: theme.numberOfCards)
        { index in
            if emojis.indices.contains(index) {
                return emojis[index]
            } else {
                return "!?"
            }
        }
        model.shuffle()
    }
    
    private var theme: ThemeChooser.Theme
    @Published private var model : MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    var getTheme: ThemeChooser.Theme {
        return self.theme
    }
    
    var themeColor: Color {
        return convertColor(color: theme.color)
    }
    
    var score: Int {
        return model.score
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
        theme = ThemeChooser().themes.randomElement()!
        model = MemoryGame(numberOfPairsOfCards: theme.numberOfCards)
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
