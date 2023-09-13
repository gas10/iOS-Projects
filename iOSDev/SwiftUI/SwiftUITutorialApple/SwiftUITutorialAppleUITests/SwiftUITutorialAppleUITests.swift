//
//  SwiftUITutorialAppleUITests.swift
//  SwiftUITutorialAppleUITests
//
//  Created by Amar Gawade on 9/10/23.
//

import XCTest

class SwiftUITutorialAppleUITests: LandscapeXCTestCase {
    var testExecutor: Page!

    override func setUp() {
        super.setUp()
        testExecutor = TestBuilder(app)
            .resetApplication()
            .setDeviceLocale()
            .setServerEnvironment(configLink: "")
            .launch()
    }

    func testLandscapeEndToEndWorkflow() throws {
        let turtleRockTitle = "Turtle Rock"
        testExecutor.on(page: LandmarkHomePage.self)
            .openTab(option: .landcapeList)
        
        testExecutor.on(page: LandmarkListPage.self)
            .toggleFavorite(isSelected: true)
        
        testExecutor.on(page: LandmarkListPage.self)
            .selectLandscape(title: turtleRockTitle)
        
        testExecutor.on(page: LandmarkDetailsPage.self)
            .verifyFavorite(isFavorite: true)
            .markFavorite(isFavorite: false)
            .verifyStaticText(text: "Joshua Tree National Park")
            .verifyStaticText(text: "California")
            .tapNavigationBar(titel: turtleRockTitle, buttonLabel: "Landmarks")
        
        testExecutor.on(page: LandmarkListPage.self)
            .toggleFavorite(isSelected: false)
            .verifyFavorite(isFavorite: false)
            .selectLandscape(title: turtleRockTitle)
        
        testExecutor.on(page: LandmarkDetailsPage.self)
            .verifyFavorite(isFavorite: false)
            .markFavorite(isFavorite: true)
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
