//
//  EmojiMemoryGame.swift
//  SwiftUITutorial
//
//  Created by Gawade, Amar on 12/28/22.
//

import Foundation
class EmojiMemoryGame: ObservableObject {
    static let emojis = ["🚙", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛",
                                "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶",
                                "🛥", "🚞", "🚤", "🚲", "🚡", "🚕", "🚟", "🚃"]
    
    static func createGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createGame()
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        // commit transaction for publishing change in object using objectWillChange.send()
        // objectWillChange.send()
        model.choose(card)
    }
}
