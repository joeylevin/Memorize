//
//  EmojiMemoryGameView.swift
//  Memorize View
//
//  Created by joey levin on 2/2/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    let themes: [Theme] = [
        Theme(key: "animals", displayText: "Animals", symbol: "dog", color: .orange, emojis: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨","🐯","🦁"]),
        Theme(key: "sea", displayText: "Sea Life", symbol: "fish", color: .blue, emojis: ["🐡","🐠","🐟","🐬","🐳","🐋","🦈","🦭","🪼","🦐","🦞","🦀","🐙","🦑"]),
        Theme(key: "produce", displayText: "Produce", symbol: "carrot", color: .red, emojis: ["🍏","🍎","🍐","🍊","🍋","🍋‍🟩","🍌","🍉","🍇","🍓","🫐","🍈","🍒","🍑","🥭","🍍","🥥","🥝","🍅","🍆","🥑"]),
        Theme(key: "sports", displayText: "Sports", symbol: "figure.baseball",color: .green, emojis: ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉","🥏","🎱","🪀","🏓","🏸","🏒","🏑","🥍"]),
        Theme(key: "cars", displayText: "Cars", symbol: "car", color: .brown, emojis: ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚐","🛻","🚚","🚛","🚜"])
    ]
    
    @State var emojis: Array<String> = []
    @State var colorTheme : Color = .black
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            cardThemeAdjusters
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 0)]) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(colorTheme)
    }
    var cardThemeAdjusters: some View {
        HStack {
            ForEach(themes, id: \.key) { theme in
                themeChooser(theme: theme)
            }
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func themeChooser(theme: Theme) -> some View {
        VStack {
            Button(action: {
                let numberOfPairs = Int.random(in: 2...(theme.emojis.count))
                emojis = (Array(theme.emojis.prefix(numberOfPairs))+Array(theme.emojis.prefix(numberOfPairs))).shuffled()
                
                colorTheme = theme.color
            }, label: {
                Image(systemName: theme.symbol)
            })
            Text(theme.displayText)
                .font(.caption)
                .alignmentGuide(.firstTextBaseline) { _ in 0}
        }
    }
    
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        } 
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

struct Theme {
    let key: String
    let displayText: String
    let symbol: String
    let color: Color
    let emojis: [String]
}




struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
