//
//  TestBuilder.swift
//  SwiftUITutorialAppleUITests
//
//  Created by Amar Gawade on 9/13/23.
//

import XCTest

class TestBuilder {
    let app: XCUIApplication
    required init(_ app: XCUIApplication) {
        self.app = app
        _ = setUserInterfaceStyle(interfaceStyle: .light)
    }
    
    func setDeviceLocale(language: DeviceLanguage = .english, locale: DeviceLocale = .us) -> Self {
        app.launchArguments += ["-AppleLanguages", language.rawValue]
        app.launchArguments += ["-AppleLocale", locale.rawValue]
        return self
    }
    
    func setUserInterfaceStyle(interfaceStyle: UIUserInterfaceStyle) -> Self {
        app.launchEnvironment["UserInterfaceStyle"] = String(interfaceStyle.rawValue)
        return self
    }
    
    func setUpSnapshotAutomation() -> Self {
        setupSnapshot(app)
        return self
    }
    
    func setUpCustomArguments(arguments: [String]) -> Self {
        app.launchArguments += arguments
        return self
    }
    
    func setServerEnvironment(configLink: String) -> Self {
        app.launchEnvironment["UITestingURL"] = configLink
        return self
    }
    
    // Reset app by deleting app data - Better than deleting app manually by long press(saves time too)
    func resetApplication() -> Self {
        app.launchEnvironment["UITestingResetApplication"] = "true"
        return self
    }
    
    func launch() -> Page {
        app.launch()
        return Page(app)
    }
}

