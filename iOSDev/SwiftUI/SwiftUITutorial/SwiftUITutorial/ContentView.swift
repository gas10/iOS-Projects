//
//  ContentView.swift
//  SwiftUITutorial
//
//  Created by Gawade, Amar on 12/6/22.
//

import SwiftUI

struct ContentView: View {
    let game = EmojiMemoryGame()
    var body: some View {
        EmojiContentView(viewModel: game)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



