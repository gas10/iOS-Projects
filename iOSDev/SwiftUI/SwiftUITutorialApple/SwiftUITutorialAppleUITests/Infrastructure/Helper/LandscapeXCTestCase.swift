//
//  LandscapeXCTestCase.swift
//  SwiftUITutorialAppleUITests
//
//  Created by Amar Gawade on 9/13/23.
//

import XCTest

class LandscapeXCTestCase: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }
}

final class App {
    static let shared = App()
    
    private var currentApp: XCUIApplication?
    
    private init() { }
    
    func terminate() {
        currentApp?.terminate()
    }
    
    func current() -> XCUIApplication {
        guard let app = currentApp else {
            let newApp = XCUIApplication()
            currentApp = newApp
            return newApp
        }
        return app
    }
}
