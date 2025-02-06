//
//  EmojiMemoryGameView.swift
//  Memorize View
//
//  Created by joey levin on 2/2/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize: \(viewModel.getTheme.name)").font(.largeTitle)
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
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
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 0)]) {
            ForEach(viewModel.cards) { card in
                CardView(card: card, theme: viewModel.getTheme, color: viewModel.themeColor)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
    }
    
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    let theme: ThemeChooser.Theme
    let color: Color
    
    init(card: MemoryGame<String>.Card, theme: ThemeChooser.Theme, color: Color) {
        self.card = card
        self.theme = theme
        self.color = color
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            Group {
                base.fill(color)
                Image(systemName: theme.symbol)
                    .imageScale(.large)
                    .font(.largeTitle)
                
            }
           .opacity(card.isFaceUp ? 0 : 1)
            base.strokeBorder(lineWidth: 2)

        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}




struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
