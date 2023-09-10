//
//  NavigationAndListContentView.swift
//  Test
//
//  Created by Amar Gawade on 9/9/23.
//

import SwiftUI

struct NavigationAndListContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct NavigationAndListContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationAndListContentView()
            .environmentObject(ModelData())
    }
}
