//
//  LandmarkListPage.swift
//  SwiftUITutorialAppleUITests
//
//  Created by Amar Gawade on 9/13/23.
//

import XCTest

class LandmarkListPage: Page {
    
    @discardableResult
    func toggleFavorite(isSelected: Bool) -> Self {
        toggleSwitch(identifier: AppAccessibilityIdentifiers.landmarkListFavoriteSwitch, isSelected: isSelected)
        return self
    }
    
    @discardableResult
    func selectLandscape(title: String) -> Self {
        tapStaticText(text: title)
        return self
    }
    
    @discardableResult
    func verifyFavorite(isFavorite: Bool) -> Self {
        verifySwitch(identifier: AppAccessibilityIdentifiers.landmarkListFavoriteSwitch, isSelected: isFavorite)
        return self
    }
}
