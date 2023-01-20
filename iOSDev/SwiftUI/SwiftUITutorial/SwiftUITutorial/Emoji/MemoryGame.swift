//
//  MemoryGame.swift
//  SwiftUITutorial
//
//  Created by Gawade, Amar on 12/28/22.
//

import Foundation
// where makes sure that CardContent is equatable to make sure == works
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private var IndexOfTheOneAndOnlyFaceUpCard: Int?

/*
    // use simple choose method
    mutating func choose(_ card: Card) {
        // The passed is viewModels card passes as struct, Even after mutation it won't change and only get copied
        // If want to change card at choosen index, change it directly. This function needs to be mutating to change cards
        // Now we need to notify changed model to view
        
        // change card using function
//        var choosenIndex = index(of: card)
//        if let choosenIndex = choosenIndex {
//            cards[choosenIndex].isFaceUp.toggle()
//        }
        
        if let choosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            cards[choosenIndex].isFaceUp.toggle()
        }
    }
  
 */
    
    func index(of: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == of.id {
                return index
            }
        }
        return nil
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var id: Int
    }
    
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = IndexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content
                {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                IndexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                IndexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp = true
        }
    }
}
