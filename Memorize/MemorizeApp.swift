//
//  MemorizeApp.swift
//  Memorize
//
//  Created by joey levin on 2/2/25.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game =  EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
