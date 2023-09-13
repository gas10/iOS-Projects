//
//  LandmarkHomePage.swift
//  SwiftUITutorialAppleUITests
//
//  Created by Amar Gawade on 9/13/23.
//

import XCTest

class LandmarkHomePage: Page {
    
    @discardableResult
    func openTab(option: Tab) -> Self {
        tap(type: .button, identifier: option.identifier)
        return self
    }
    
    
    enum Tab {
        case featuredLandscape
        case landcapeList
        
        var identifier: String {
            switch self {
            case .featuredLandscape:
                return AppAccessibilityIdentifiers.featuredLandscapeLabel
            case .landcapeList:
                return AppAccessibilityIdentifiers.showLandscapeListLabel
            }
        }
    }
}
