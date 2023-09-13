//
//  Page.swift
//  SwiftUITutorialAppleUITests
//
//  Created by Amar Gawade on 9/13/23.
//

import XCTest

// enums
enum UIState: String {
    case exists = "exists == true"
    case notExists = "exists == false"
    case hittable = "isHittable == true"
    case notHittable = "isHittable == false"
}

enum Timeout: Double {
    case short = 10
    case medium = 30
    case long = 60
    
    case oneSec = 1
    case fiveSec = 5
}

enum SleepTime: UInt32 {
    case oneSec = 1
    case twoSec = 2
    case fiveSec = 5
}

enum ElementType {
    case button
    case staticText
}


class Page {
    var app: XCUIApplication
    
    required init(_ app: XCUIApplication) {
        self.app = app
    }
    
    func on<T: Page>(page: T.Type) -> T {
        let nextPage: T
        // avoid duplicate initialization
        if let tSelf = self as? T {
            nextPage = tSelf
        } else {
            nextPage = page.init(app)
        }
        return nextPage
    }
    
    // Tap
    @discardableResult
    func tap(element: XCUIElement) -> Self {
        waitFor(element: element, status: .hittable)
        element.tap()
        return self
    }
    
    @discardableResult
    func tap(type: XCUIElement.ElementType, identifier: String) -> Self {
        let matchedElement = app.descendants(matching: type).matching(identifier: identifier).firstMatch
        matchedElement.tap()
        return self
    }
    
    // Tap static text
    @discardableResult
    func tapStaticText(identifier: String) -> Self {
        let predicate = NSPredicate(format: "idetifier == %@", identifier)
        let matchedElement = app.staticTexts.matching(predicate).firstMatch
        matchedElement.tap()
        return self
    }
    
    @discardableResult
    func tapStaticText(text: String) -> Self {
        let predicate = NSPredicate(format: "label == %@", text)
        let matchedElement = app.staticTexts.matching(predicate).firstMatch
        matchedElement.tap()
        return self
    }
    
    @discardableResult
    func tapMatchingStaticText(text: String) -> Self {
        let predicate = NSPredicate(format: "label CONTAINS[C] %@", text)
        let matchedElement = app.staticTexts.matching(predicate).firstMatch
        matchedElement.tap()
        return self
    }
    
    // tap switch
    @discardableResult
    func toggleSwitch(identifier: String, isSelected: Bool) -> Self {
        let expectedValue = isSelected ? "1" : "0"
        let switchElement = app.switches[identifier].firstMatch
        if let value = switchElement.value as? String, value != expectedValue {
            switchElement.tap()
        }
        return self
    }
    
    // Waiting
    @discardableResult
    func waitFor(element: XCUIElement, status: UIState, timeout: Double = Timeout.short.rawValue) -> Self {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: status.rawValue), object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        if result == .timedOut {
            XCTFail(expectation.description)
        }
        return self
    }
    
    // verify
    @discardableResult
    func verifySwitch(identifier: String, isSelected: Bool) -> Self  {
        let expectedValue = isSelected ? "1" : "0"
        let switchElement = app.switches[identifier].firstMatch
        guard let value = switchElement.value as? String else {
            XCTFail("Invalid switch value")
            return self
        }
        XCTAssertEqual(value, expectedValue, "Invalid switch value")
        return self
    }
    
    @discardableResult
    func verifyElement(type: XCUIElement.ElementType, identifier: String, isExists: Bool = true) -> Self {
        let matchedElement = app.descendants(matching: type).matching(identifier: identifier).firstMatch
        XCTAssertTrue(matchedElement.exists == isExists,
                      "Not matched for type \(type.rawValue), identifier: \(identifier), isExists: \(isExists)")
        return self
    }
    
    @discardableResult
    func verifyStaticText(text: String, isExists: Bool = true) -> Self  {
        let predicate = NSPredicate(format: "label CONTAINS[C] %@", text)
        let matchedElement = app.descendants(matching: .any).matching(predicate).firstMatch
        XCTAssertTrue(matchedElement.exists == isExists,
                      "Not matched for text \(text), isExists: \(isExists)")
        return self
    }
    
    // navigation
    func tapNavigationBar(titel: String, buttonLabel: String) {
        let button = app.navigationBars[titel].buttons[buttonLabel].firstMatch
        button.tap()
    }
}

/*
class Page {
    var app: XCUIApplication
    lazy var closeIconOnShareActivity = app.navigationBars[AppAccessibilityIdentifiers.activityContentView].buttons.element(boundBy: 0)
    // for multi task mode, check if ipad view is in compact mode or not
    var isCompact: Bool {
        let isCompactHeight = app.windows.firstMatch.frame.height < (UIScreen.main.bounds.height * (4/5))
        let isCompactWidth = app.windows.firstMatch.frame.width < (UIScreen.main.bounds.width * (4/5))
        return isCompactHeight || isCompactWidth
    }
    required init(_ app: XCUIApplication) {
        self.app = app
    }
    func on<T: Page>(page: T.Type) -> T {
        let nextPage: T
        // avoid duplicate initialization
        if let tSelf = self as? T {
            nextPage = tSelf
        } else {
            nextPage = page.init(app)
        }
        return nextPage
    }
    @discardableResult
    func tap(element: XCUIElement) -> Self {
        waitFor(element: element, status: .hittable)
        element.tap()
        return self
    }
    func doubleTap(element: XCUIElement) {
        waitFor(element: element, status: .hittable)
        element.doubleTap()
    }
    func tapIfExists(element: XCUIElement) {
        if element.waitForExistence(timeout: 10) {
            element.tap()
        }
    }
    func typeText(element: XCUIElement, text: String) {
        waitFor(element: element, status: .exist)
        element.typeText(text)
    }
    @discardableResult
    func waitFor(element: XCUIElement, status: UIState, timeout: Double = 10) -> Self {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: status.rawValue), object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        if result == .timedOut {
            XCTFail(expectation.description)
        }
        return self
    }
    func elementFoundAfterWait(element: XCUIElement, status: UIState, timeout: Double = 10) -> Bool {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: status.rawValue), object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        return result != .timedOut
    }
    func verify(_ element: XCUIElement) -> Bool {
        if element.exists && element.isHittable {
            return true
        } else {
            return false
        }
    }
    func queryLocalizedElement(_ type: XCUIElement.ElementType = .any, key: String, predicateQuery: String? = nil) -> XCUIElementQuery {
        let localized = app.localized(key: key)
        guard let query = predicateQuery else {
            return app.descendants(matching: .any).matching((type), identifier: localized)
        }
        let predicate = NSPredicate(format: query, localized)
        return app.descendants(matching: .any).matching(predicate)
    }
    func elementTypeIdQuery (_ type: XCUIElement.ElementType, identifier: String) -> XCUIElementQuery {
        return app.descendants(matching: .any).matching((type), identifier: identifier)
    }
    func elementIdQuery(_ elementID: String) -> XCUIElementQuery {
        return app.descendants(matching: .any).matching(identifier: elementID)
    }
    @discardableResult
    func checkNotExist (_ typ: XCUIElement.ElementType, iden: String, test: XCTestCase) -> Self {
        let expectAppear = NSPredicate(format: "exists == false")
        let object = elementTypeIdQuery(typ, identifier: iden).element
        test.expectation(for: expectAppear, evaluatedWith: object, handler: nil)
        test.waitForExpectations(timeout: 45, handler: nil)
        return self
    }
    @discardableResult
    func verifyAppearAndTap(_ typ: XCUIElement.ElementType, iden: String, time: TimeInterval = 0.1, index: Int = 0) -> Self {
        let predicate = NSPredicate(format: expectContain, iden)
        let containLabel = app.descendants(matching: typ).matching(predicate).element(boundBy: index)
        let exactLabel = app.descendants(matching: typ).matching(identifier: iden).element(boundBy: index)
        if verify(exactLabel) {
            exactLabel.press(forDuration: time)
        } else {
            containLabel.press(forDuration: time)
        }
        return self
    }
    func verifyElement(_ expection: NSPredicate, _ elem: XCUIElement, _ test: XCTestCase) {
        test.expectation(for: expection, evaluatedWith: elem, handler: nil)
        test.waitForExpectations(timeout: waitForExpectationTime, handler: nil)
    }
    func verifyAppearAndTap(_ elem: XCUIElement, time: TimeInterval = 0.1, test: XCTestCase) {
        verifyElement(expectHittable, elem, test)
        elem.firstMatch.press(forDuration: time)
    }
    @discardableResult
    func tapCellStaticText(text: String) -> Self {
        let predicate = NSPredicate(format: "label == %@", text)
        let filterOption = app.cells.staticTexts.matching(predicate).firstMatch
        filterOption.tap()
        return self
    }
    @discardableResult
    func verifyStaticText(text: String, exists: Bool) -> Self {
        let staticText = app.staticTexts[text].firstMatch
        waitFor(element: staticText, status: exists ? .exist : .notExist)
        return self
    }
    func verifyButton(name: String, enabled: Bool) {
        let button = app.buttons[name].firstMatch
        XCTAssertEqual(button.isEnabled, enabled)
    }
    func timeElapsedInSecondsWhenRunningCode(operation: () -> Void) -> Double {
        let startTime = CFAbsoluteTimeGetCurrent()
        operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        return Double(timeElapsed)
    }
    func waitForDossierExecutionAndRender(test: XCTestCase) {
        let maxWait = 50
        var waitCount = 0
        while waitCount < maxWait &&
            (elementTypeIdQuery(.any, identifier: "Connecting Server...").element.exists ||
            elementTypeIdQuery(.any, identifier: "Executing dossier...").element.exists ||
            elementTypeIdQuery(.any, identifier: "Downloading data...").element.exists ||
            elementTypeIdQuery(.any, identifier: "Rendering content...").element.exists ||
            elementTypeIdQuery(.any, identifier: "Loading...").element.exists ||
            elementTypeIdQuery(.any, identifier: "Running...").element.exists) /*||
             elementTypeIdQuery(.other, id: "uitest.loading").element.exists*/ {
                sleep(2)
                waitCount += 1
        }
    }
    func waitForToastGone(message: String) {
        let predicate = NSPredicate(format: "label CONTAINS[C] %@", message)
        let toast = app.staticTexts.containing(predicate).firstMatch
        waitFor(element: toast, status: .notExist)
    }
    func dismissShareDialogActivity() {
        verifyAppearAndTap(.button, iden: "Cancel")
    }
    //   static text represening progress spinner we can use to decide whether action is complete
    func verifyElementHittable (name: String, type: XCUIElement.ElementType, test: XCTestCase, timeout: TimeInterval) {
        let currentElement = app.descendants(matching: .any).matching(type, identifier: name).element
        let verifyEnable = NSPredicate(format: "enabled = 1")
        test.expectation(for: verifyEnable, evaluatedWith: currentElement, handler: nil)
        test.waitForExpectations(timeout: timeout, handler: nil)
    }
    @discardableResult
    func verifyExist (_ typ: XCUIElement.ElementType, iden: String, test: XCTestCase) -> Self {
        let expectAppear = NSPredicate(format: "exists == true")
        let object = elementTypeIdQuery(typ, identifier: iden).element
        test.expectation(for: expectAppear, evaluatedWith: object, handler: nil)
        test.waitForExpectations(timeout: 45, handler: nil)
        return self
    }
    // x, y position
    func getCoordinates(_ point: CGPoint) -> XCUICoordinate {
        let orientation = XCUIDevice.shared.orientation
        var transPoint = app.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
            .withOffset(CGVector(dx: point.x, dy: point.y))
        if orientation == .portrait || orientation == .landscapeLeft || orientation == .landscapeRight {
            transPoint = app.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
                .withOffset(CGVector(dx: point.x, dy: point.y))
        }
        return transPoint
    }
    @discardableResult
    func tapCoordinate(at xCoordinate: Double, and yCoordinate: Double, times: Int = 1) -> Self {
        let normalized = app.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let coordinate = normalized.withOffset(CGVector(dx: xCoordinate, dy: yCoordinate))
        for _ in 0..<times {
            coordinate.tap()
        }
        return self
    }
    // in iPhone tap on close icon to close the share activity, for iPad we need to tap outside the panel
    @discardableResult
    func dismissSharePopUpActivity() -> Self {
        if isIPhone() || isCompact {
            waitFor(element: closeIconOnShareActivity, status: .hittable, timeout: TimeOut.twentySec.rawValue)
            closeIconOnShareActivity.tap()
        } else {
            // for iPad we can tap any where outside the panel to dismiss it
            dismissPopoverByBackgroundTap()
        }
        return self
    }
    func swipeUpInCollectionViewToElementWith(elementName: String) {
        let element = app.staticTexts[elementName]
        while !(elementIsWithinWindows(element: element)) {
            app.collectionViews.firstMatch.swipeUp()
        }
    }
    func elementIsWithinWindows(element: XCUIElement) -> Bool {
        guard element.exists && element.isHittable else { return false }
        return true
    }
    func changeDeviceOrientation(orientation: DeviceOrientation) {
        switch orientation {
        case .landscaperight:
            XCUIDevice.shared.orientation = .landscapeRight
        case .landscapeleft:
            XCUIDevice.shared.orientation = .landscapeLeft
        case .portrait:
            XCUIDevice.shared.orientation = .portrait
        case .portraitUpsideDown:
            XCUIDevice.shared.orientation = .portraitUpsideDown
        }
    }
    func getInitialDeviceOrientation() -> UIDeviceOrientation {
        return XCUIDevice.shared.orientation == .unknown ? .portrait : XCUIDevice.shared.orientation
    }
    func setDeviceOrientation(orientation: UIDeviceOrientation) {
        XCUIDevice.shared.orientation = orientation
    }
    func longPress(element: XCUIElement, forDuration duration: TimeInterval) {
        waitFor(element: element, status: .hittable)
        element.press(forDuration: duration)
    }
    func dismissPopoverByBackgroundTap() {
        let background = app.otherElements[popoverDismissRegion].firstMatch
        waitFor(element: background, status: .hittable, timeout: TimeOut.twentySec.rawValue)
        background.tap()
    }
    func switchSplitScreenMode(to mode: SplitScreenMode) {
        app.beginMultitasking()
        app.switchSplitScreenMode(to: mode)
    }
    // generic click cancel function
    func clickCancel() {
        let cancelButton = app.buttons[StringConstant.cancel].firstMatch
        waitFor(element: cancelButton, status: .hittable)
        cancelButton.tap()
    }
    // MARK: Localization Related helper methods
    func verifyTranslationNotEmpty(elements: [XCUIElement], expected: Bool = true) {
        for element in elements {
            waitFor(element: element, status: .exist)
            let labelText = element.label
            XCTAssert(!labelText.contains("*") && labelText.count > 0,
                      "Translation is missing or not added to the database")
        }
    }
    func verifyLocalizedStringsEqual(element: XCUIElement, actualText: String) {
        waitFor(element: element, status: .exist)
        let labelText = element.label
        XCTAssertEqual(labelText, actualText, "Localized Strings not Equal")
    }
    func terminateApp() {
        app.terminate()
    }
    func dismissPanelCompact (panelTitle: String) {
        let closeButton = app.navigationBars[panelTitle].buttons["Close"].firstMatch
        closeButton.tap()
    }
    // scroll up to reach specified element
    func scrollUpToReachElement(expectedElement: XCUIElement) {
        while !expectedElement.isVisible() {
            app.swipeDown()
        }
    }
    @discardableResult
    func pinchToZoomGesture() -> Self {
        app.pinch(withScale: 2, velocity: 1)
        return self
    }
    func scrollToTheElement(element: XCUIElement, swipeDirection: TestSwipeDirections, maxSwipeCount: Int = 50) {
        var currentCount = 0
        while !element.isVisible() && currentCount < maxSwipeCount {
            switch swipeDirection {
            case .up:
                app.gentleSwipe(.up)
            case .down:
                app.gentleSwipe(.down)
            case .left:
                app.gentleSwipe(.left)
            case .right:
                app.gentleSwipe(.right)
            }
            currentCount += 1
        }
    }
    func toggleSwitch(switchElement: XCUIElement, shouldEnable: Bool) {
        // check the switch's current status
        let expectedValue = shouldEnable ? "1" : "0"
        if let value = switchElement.value as? String, value != expectedValue {
            switchElement.tap()
        }
    }
    func waitForAppFirstLaunch() {
        _ = app.buttons["Get Started"].waitForExistence(timeout: 15)
    }
    @discardableResult
    func waitForOtherTextToAppear(text: String) -> Self {
        let predicate = NSPredicate(format: "label CONTAINS %@", text)
        let element = app.otherElements.matching(predicate).firstMatch
        waitFor(element: element, status: .exist, timeout: TimeOut.tenSec.rawValue)
        return self
    }
    @discardableResult
    func waitForStaticTextToAppear(text: String) -> Self {
        let predicate = NSPredicate(format: "label CONTAINS %@", text)
        let element = app.staticTexts.matching(predicate).firstMatch
        waitFor(element: element, status: .exist, timeout: TimeOut.tenSec.rawValue)
        return self
    }
    @discardableResult
    func tapStaticText(text: String) -> Self {
        let predicate = NSPredicate(format: "label == %@", text)
        let element = app.staticTexts.matching(predicate).firstMatch
        tap(element: element)
        return self
    }
    @discardableResult
    func verifyLocalizedStaticText(for key: String) -> Self {
        let localizedText = app.localized(key: key)
        let staticText = app.descendants(matching: .any).matching(identifier: localizedText).firstMatch
        waitFor(element: staticText, status: .exist, timeout: 20)
        return self
    }
    @discardableResult
    func verifyLocalizedStaticTextByLabel(for key: String, suffix: String = "", elementType: XCUIElement.ElementType = .staticText) -> Self {
        let localizedText = app.localized(key: key) + suffix
        let staticText = app.descendants(matching: elementType).matching(NSPredicate(format: "label == %@", localizedText)).firstMatch
        waitFor(element: staticText, status: .exist, timeout: 20)
        return self
    }
    @discardableResult
    func verifyLocalizedStaticTextCaseInsensitive(for key: String, suffix: String = "", elementType: XCUIElement.ElementType = .staticText) -> Self {
        let localizedText = app.localized(key: key) + suffix
        let staticText = app.descendants(matching: elementType).matching(NSPredicate(format: "label ==[c] %@", localizedText)).firstMatch
        waitFor(element: staticText, status: .exist, timeout: 20)
        return self
    }
    @discardableResult
    func sendAppToBackgroundAndBack() -> Self {
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        sleep(5)
        app.activate()
        return self
    }
    // MARK: generic helper functions
    @discardableResult
    func toggleOfflineMode(enabled: Bool) -> Self {
        on(page: LibraryPage.self).invokeOptionsSettings()
        on(page: SettingsPage.self)
            .invokeAdvancedSettings()
            .enableOfflineModeSwitch()
            .switchOfflineMode(shouldTurnOn: enabled)
            .dismissAdvancedSettingsScreen()
        // go back to library home page
        on(page: LibraryPage.self)
            .switchToSideBar(optionLabel: app.localized(key: LocalizationStringKey.all))
        return self
    }
    func checkAccessibility(cell: XCUIElement, numberOfElements: Int, expectedLabels: [String], elementType: ElementType, checkContains: Bool = false) {
        var targetElements: [XCUIElement]
        switch elementType {
        case .button: targetElements = cell.buttons.allElementsBoundByIndex
        case .switchButton: targetElements = cell.switches.allElementsBoundByIndex
        case .staticText: targetElements = cell.staticTexts.allElementsBoundByIndex.filter { !$0.label.isEmpty }
        }
        XCTAssertEqual(targetElements.count, numberOfElements)
        for (expectedLabel, element) in zip(expectedLabels, targetElements) {
            let result = element.label == expectedLabel
            if !result && checkContains {
                XCTAssertTrue(element.label.contains(expectedLabel))
            } else {
                XCTAssertTrue(result)
            }
        }
    }
    @discardableResult
    func dismissMemoryLeak() -> Bool {
        let okButton = app.buttons[app.localized(key: LocalizationStringKey.okButtonText)].firstMatch
        guard okButton.waitForExistence(timeout: TimeOut.fiveSec.rawValue) else { return false }
        tap(element: okButton)
        return true
    }
}
extension XCUIApplication {
    func getLocalizationBundle() -> Bundle? {
        let bundle = Bundle(for: Page.self)
        if let path = bundle.path(forResource: "FinalBundle", ofType: "bundle") {
            if let localizationBundle = Bundle(path: path) {
                return localizationBundle
            }
        }
        return bundle
    }
    func localized(key: String) -> String {
        guard let localizationBundle = getLocalizationBundle() else { return ""}
        let appLocale = getAppleLocale()
        let path = localizationBundle.path(forResource: appLocale, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(key, tableName: "IPhoneStrings", bundle: bundle!, value: "", comment: "")
    }
    // read apple locale from launch arguments or return en as default
    func getAppleLocale() -> String {
        guard let indexOfAppLocaleKey = launchArguments.firstIndex(of: "-AppleLocale"), launchArguments.count > indexOfAppLocaleKey + 1 else {
            return LprojLanguageCode.english.rawValue
        }
        return languageCodeDictionary[launchArguments[indexOfAppLocaleKey + 1]] ?? LprojLanguageCode.english.rawValue
    }
    // read apple locale from launch arguments and return device locale string or return us as default
    func getDeviceLocale() -> String {
        guard let indexOfAppLocaleKey = launchArguments.firstIndex(of: "-AppleLocale"), launchArguments.count > indexOfAppLocaleKey + 1 else {
            return DeviceLocale.us.rawValue
        }
        return launchArguments[indexOfAppLocaleKey + 1]
    }
}

*/
