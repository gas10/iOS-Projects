//
//  EmojiMemoryGameView.swift
//  SwiftUITutorial
//
//  Created by Gawade, Amar on 12/28/22.
//

import Foundation
import SwiftUI

struct EmojiContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            // Adding HStack
//            HStack {
//                ForEach(vehicleEmojis[0..<totalCount], id: \.self) { emoji in
//                    CardView(content: emoji)
//                }
//            }
            
            // Multiple grid item - columns: [GridItem(), GridItem(), GridItem()]
            
            // Add scroll view to avoid add/remove hidden below
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                addItem
                Spacer()
                removeItem
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
    }
    
    var addItem: some View {
        Button {
            
        } label: {
            Image(systemName: "plus")
                .font(.largeTitle)
                .padding()
        }
    }
    
    var removeItem: some View {
        Button {
            
        } label: {
            Image(systemName: "minus")
                .font(.largeTitle)
                .padding()
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct EmojiContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiContentView(viewModel: EmojiMemoryGame())
    }
}

/*
 Lecture 1
 struct EmojiContentView: View {
     let vehicleEmojis = ["🚙", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛",
                           "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶",
                           "🛥", "🚞", "🚤", "🚲", "🚡", "🚕", "🚟", "🚃"]
     @State var totalCount = 4
     var body: some View {
         VStack {
             // Adding HStack
             HStack {
                 ForEach(vehicleEmojis[0..<totalCount], id: \.self) { emoji in
                     CardView(content: emoji)
                 }
             }
             
             // Multiple grid item - columns: [GridItem(), GridItem(), GridItem()]
             
             // Add scroll view to avoid add/remove hidden below
             
             ScrollView {
                 LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
                     ForEach(vehicleEmojis[0..<totalCount], id: \.self) { emoji in
                         CardView(content: emoji)
                             .aspectRatio(2/3, contentMode: .fit)
                     }
                 }
             }
             .foregroundColor(.red)
             Spacer()
             HStack {
                 addItem
                 Spacer()
                 removeItem
             }
             .font(.largeTitle)
             .padding(.horizontal)
         }
     }
     
     var addItem: some View {
         Button {
             totalCount = totalCount + 1
         } label: {
             Image(systemName: "plus")
                 .font(.largeTitle)
                 .padding()
         }
     }
     
     var removeItem: some View {
         Button {
             if totalCount > 1 {
                 totalCount = totalCount - 1
             }
         } label: {
             Image(systemName: "minus")
                 .font(.largeTitle)
                 .padding()
         }
     }
 }
 */
