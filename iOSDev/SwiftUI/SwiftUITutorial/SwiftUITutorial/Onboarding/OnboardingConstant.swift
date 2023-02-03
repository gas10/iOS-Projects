
import UIKit
struct OnboardingConstant {
    // Colors
//    let button
    static let backgroundColor: UIColor = .blue
    static let primaryBackgroundColor: UIColor = .lightGray
    static let textColor: UIColor = .white
    
    static let dossierBlue: UIColor = UIColor(fromHexString: "#0E6FF9")
    // Strings
    static let skipString = "SKIP".localized("Skip")
    static let getStartedString = "GET_STARTED".localized("Get Started")
    static let NextString = "NEXT".localized("Next")
}

struct OnboardingTutorialString {
    //// swiftlint:disable line_length
    // 1.Blue screen landing - insight, data driven and share/collaborate
    static let insightTitle = "ONBOARDING_PAGE_1_TITLE_NEW".localized("Get Powerful Insights")
    static let insightSubtitle = "ONBOARDING_PAGE_1_SUBTITLE_V2".localized("View dossiers, reports and documents in your library. Create personal bookmark views to save specific insights.")
    static let dataDrivenTitle = "ONBOARDING_PAGE_2_TITLE_NEW".localized("Make Data-Driven Decisions")
    static let dataDrivenSubtitle = "ONBOARDING_PAGE_2_SUBTITLE_NEW".localized("Navigate through content and filter visualizations to get the data you need.")
    static let shareAndCollaborateTitle =  "ONBOARDING_PAGE_3_TITLE_NEW".localized("Share and Collaborate")
    static let shareAndCollaborateSubtitle = "ONBOARDING_PAGE_3_SUBTITLE_NEW".localized("Use direct messages and group discussions to collaborate and exchange ideas across teams.")
    
    static let landingTitles = [insightTitle, dataDrivenTitle, shareAndCollaborateTitle]
    static let landingSubtitles = [insightSubtitle, dataDrivenSubtitle, shareAndCollaborateSubtitle]
    static let landingiPadImages = ["Tutorial_image1_iPad", "Tutorial_image2_iPad", "Tutorial_image3_iPad"]
    static let landingiPhoneImages = ["Tutorial_image1_Phone", "Tutorial_image2_Phone", "Tutorial_image3_Phone"]
    
    // 2. homepage - sidebar, favorite and group
    static let sidebarTitle = "SIDEBAR_MENU".localized("Sidebar Menu")
    static let sidebarDesc = "SIDEBAR_TUTORIAL_INFO".localized("Easily navigate and manage your content in a centralized location.")
    static let favoritesTitle = "FAVORITES".localized("Favorites")
    static let favoritesDesc = "FAVORITES_TUTORIAL_INFO".localized("Select your top content to appear in the Favorites section.")
    static let myGroupsTitle = "MY_GROUPS".localized("My Groups")
    static let myGroupsDesc = "MY_GROUPS_TUTORIAL_INFO".localized("Create custom groups with specific content to help better organize your library.")
    
    static let sidebarTutorialImage = "Tutorial_Sidebar"
    static let favoriteTutorialImage = "Tutorial_Favorite"
    static let myGroupsTutorialImage = "Tutorial_My groups"
    
    static let libraryHomepageTitles = [sidebarTitle, favoritesTitle, myGroupsTitle]
    static let libraryHomepageSubtitles = [sidebarDesc, favoritesDesc, myGroupsDesc]
    static let libraryHomepageImages = [sidebarTutorialImage, favoriteTutorialImage, myGroupsTutorialImage]
    
    // 3. Dossier - single tap, swipe and hold
    static let singleTapGestureTitle = "TUTORIAL_GESTURE_SWITCH_PAGES".localized("Switch Pages")
    static let singleTapGestureSubtitle = "TUTORIAL_GESTURE_SWITCH_PAGES_DESC".localized("Swipe with one finger")
    static let swipeGestureTitle = "TUTORIAL_GESTURE_MAX_VIZ".localized("Maximize Visualization")
    static let swipeGestureSubtitle = "TUTORIAL_GESTURE_MAX_VIZ_DESC".localized("Double tap with one finger")
    static let holdGestureTitle = "TUTORIAL_GESTURE_CONTEXT_MENU".localized("View Context Menu")
    static let holdGestureSubtitle = "TUTORIAL_GESTURE_CONTEXT_MENU_DESC".localized("Tap and hold with one finger")
    
    static let singleTapGestureImage = "tutorial_gesture_1"
    static let swipeGestureImage = "tutorial_gesture_2"
    static let holdGestureImage = "Tutorial_My tutorial_gesture_3"
    
    static let dossierTitles = [singleTapGestureTitle, swipeGestureTitle, holdGestureTitle]
    static let dossierSubtitles = [singleTapGestureSubtitle, swipeGestureSubtitle, holdGestureSubtitle]
    static let dossierImages = [singleTapGestureImage, swipeGestureImage, holdGestureImage]
    
    
    // 4. Toolbar buttons - toc, bookmark, filter and collaborate
    static let tocTitle = "TUTORIALS_DOSSIER_TITLE_1".localized("Table of Contents")
    static let tocSubtitle = "TUTORIALS_DOSSIER_DESCRIPTION_1_IOS".localized("Navigate intuitively with chapters and pages. You can dive directly into specific pages to view the data you need to make decisions.")
    static let bookmarksTitle = "BOOKMARKS".localized("Bookmarks")
    static let bookmarksSubtitle = "TUTORIALS_BOOKMARKS_DESCRIPTION".localized("Create a bookmark to save your personal view of the entire dossier, including all filters, in-canvas selections, prompt answers, and more.")
    static let filterTitle = "TUTORIALS_DOSSIER_TITLE_2".localized("Easily Filter Your Data")
    static let filterSubtitle = "TUTORIALS_DOSSIER_DESCRIPTION_2_IOS".localized("Add or remove filter conditions with just a few taps. The filter panel provides a simple design to build a unique view of your data for analysis.")
    static let collaborationTitle = "TUTORIALS_DOSSIER_TITLE_3".localized("Share Insights Realtime")
    static let collaborationSubtitle = "TUTORIALS_DOSSIER_DESCRIPTION_3_IOS".localized("Tag your team members and send messages with embedded filters to communicate with context in real time. You will receive an alert when you are mentioned.")
    
    static let tocImage = "ToC BG"
    static let bookmarkImage = "Bookmarks BG"
    static let filterImage = "Filter BG"
    static let collaborateImage = "Comments BG"
    
    static let toolbarTitles = [tocTitle, bookmarksTitle, filterTitle, collaborationTitle]
    static let toolbarSubtitles = [tocSubtitle, bookmarksSubtitle, filterSubtitle, collaborationSubtitle]
    static let toolbarImages = [tocImage, bookmarkImage, filterImage, collaborateImage]
    // swiftlint:enable line_length
}


extension String {
    func localized(_ defaultValue: String) -> String {
        return defaultValue
    }
}

extension UIColor {
    convenience init(fromHexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = fromHexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
