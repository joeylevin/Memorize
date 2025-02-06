//
//  Theme.swift
//  Memorize Theme Model
//
//  Created by joey levin on 2/6/25.
//

import Foundation

struct ThemeChooser {
 
    let themes: [Theme] = [
        Theme(key: "animals", name: "Animals", symbol: "dog", color: "orange", numberOfCards: 8, emojis: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁"]),
        Theme(key: "sea", name: "Sea Life", symbol: "fish", color: "blue", numberOfCards: 10, emojis: ["🐡","🐠","🐟","🐬","🐳","🐋","🦈","🦭","🪼","🦐","🦞","🦀","🐙","🦑"]),
        Theme(key: "produce", name: "Produce", symbol: "carrot", color: "red", numberOfCards: 15, emojis: ["🍏","🍎","🍐","🍊","🍋","🍋‍🟩","🍌","🍉","🍇","🍓","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅","🍆","🥑"]),
        Theme(key: "sports", name: "Sports", symbol: "figure.baseball",color: "green", numberOfCards: 12, emojis: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥏","🎱","🪀","🏓","🏸","🏒","🏑","🥍"]),
        Theme(key: "cars", name: "Cars", symbol: "car", color: "brown", numberOfCards: 6, emojis: ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜"])
    ]

    struct Theme {
        let key: String
        let name: String
        let symbol: String
        let color: String
        let numberOfCards: Int
        let emojis: [String]
    }
        
}
