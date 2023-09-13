//
//  ContentView.swift
//  SwiftUITutorialApple
//
//  Created by Amar Gawade on 9/10/23.
//


import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured

    enum Tab {
        case featured
        case list
    }

    var body: some View {
        TabView(selection: $selection) {
            CategoryHome()
                .tabItem {
                    Label("Featured", systemImage: "star")
                        .accessibilityIdentifier(AppAccessibilityIdentifiers.featuredLandscapeLabel)
                }
                .tag(Tab.featured)

            LandmarkList()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                        .accessibilityIdentifier(AppAccessibilityIdentifiers.showLandscapeListLabel)
                }
                .tag(Tab.list)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
