//
//  MemorizeGame.swift
//  Memorize Model
//
//  Created by joey levin on 2/5/25.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    var score: Int
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        score = 0
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            let id = UUID().uuidString
            cards.append(Card(content: content, id: "\(id)a"))
            cards.append(Card(content: content, id: "\(id)b"))
        }
    }
        
    mutating func shuffle() {
        cards.shuffle()
    }
    
    var indexOfFaceupCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfFaceupCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        // Found a match
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        // Mismatch handling
                        if cards[chosenIndex].previouslySeen { score -= 1 }
                        if cards[potentialMatchIndex].previouslySeen { score -= 1 }
                        cards[chosenIndex].previouslySeen = true
                        cards[potentialMatchIndex].previouslySeen = true
                    }
                } else {
                    indexOfFaceupCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
        }
        
        var isFaceUp = false
        var isMatched = false
        var previouslySeen = false
        let content: CardContent
        var id: String
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
