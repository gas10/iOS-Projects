//
//  LandmarkDetailsPage.swift
//  SwiftUITutorialAppleUITests
//
//  Created by Amar Gawade on 9/13/23.
//


import XCTest

class LandmarkDetailsPage: Page {
    @discardableResult
    func markFavorite(isFavorite: Bool) -> Self {
        tap(type: .button, identifier: !isFavorite ?
            AppAccessibilityIdentifiers.landmarkDetailsFavoriteButton : AppAccessibilityIdentifiers.landmarkDetailsNotFavoriteButton)
        return self
    }
    
    @discardableResult
    func verifyFavorite(isFavorite: Bool) -> Self {
        verifyElement(type: .button, identifier: isFavorite ?
                      AppAccessibilityIdentifiers.landmarkDetailsFavoriteButton : AppAccessibilityIdentifiers.landmarkDetailsNotFavoriteButton)
        return self
    }
}

