//
//  ContentView.swift
//  WatchSwiftUITutorialApple WatchKit Extension
//
//  Created by Amar Gawade on 9/13/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
