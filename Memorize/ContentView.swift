//
//  ContentView.swift
//  Memorize
//
//  Created by joey levin on 2/2/25.
//

import SwiftUI

struct ContentView: View {
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
            }
            Spacer()
            cardThemeAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
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
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct Theme {
    let key: String
    let displayText: String
    let symbol: String
    let color: Color
    let emojis: [String]
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
