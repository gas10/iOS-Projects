
import Foundation

enum OnboardingTutorialType {
    case landing
    case homepage
    case dossier
    case toolbar(ToolbarTutorialType)
}

enum ToolbarTutorialType: CaseIterable {
    case toc
    case bookmark
    case filter
    case collaboration
    case all
}


struct OnboardingTutorialData: Hashable, Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let type: OnboardingTutorialType
    let image: String?
    
    init(id: Int, title: String, subtitle: String, type: OnboardingTutorialType, image: String? = nil) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.type = type
        self.image = image
    }
    
    static func getDataFor(type: OnboardingTutorialType) -> [OnboardingTutorialData] {
        var tutorials = [OnboardingTutorialData]()
        switch type {
        case .landing:
            for index in 0..<OnboardingTutorialString.landingTitles.count {
                let tutorial = OnboardingTutorialData(id: index,
                                                      title: OnboardingTutorialString.landingTitles[index],
                                                      subtitle: OnboardingTutorialString.landingSubtitles[index],
                                                      type: .landing,
                                                      image: OnboardingTutorialString.landingiPadImages[index])
                tutorials.append(tutorial)
            }
        case .homepage:
            for index in 0..<OnboardingTutorialString.libraryHomepageTitles.count {
                let tutorial = OnboardingTutorialData(id: index,
                                                      title: OnboardingTutorialString.libraryHomepageTitles[index],
                                                      subtitle: OnboardingTutorialString.libraryHomepageSubtitles[index],
                                                      type: .homepage,
                                                      image: OnboardingTutorialString.libraryHomepageImages[index])
                tutorials.append(tutorial)
            }
        case .dossier:
            for index in 0..<OnboardingTutorialString.dossierTitles.count {
                let tutorial = OnboardingTutorialData(id: index,
                                                      title: OnboardingTutorialString.dossierTitles[index],
                                                      subtitle: OnboardingTutorialString.dossierSubtitles[index],
                                                      type: .dossier,
                                                      image: OnboardingTutorialString.dossierImages[index])
                tutorials.append(tutorial)
            }
        case .toolbar(.all):
            for index in 0..<OnboardingTutorialString.toolbarTitles.count {
                let tutorial = OnboardingTutorialData(id: index,
                                                      title: OnboardingTutorialString.toolbarTitles[index],
                                                      subtitle: OnboardingTutorialString.toolbarSubtitles[index],
                                                      type: .toolbar(ToolbarTutorialType.allCases[index]),
                                                      image: OnboardingTutorialString.toolbarImages[index])
                tutorials.append(tutorial)
            }
        default:
            for index in 0..<OnboardingTutorialString.libraryHomepageTitles.count {
                let tutorial = OnboardingTutorialData(id: index,
                                                      title: OnboardingTutorialString.libraryHomepageTitles[index],
                                                      subtitle: OnboardingTutorialString.libraryHomepageSubtitles[index],
                                                      type: .dossier,
                                                      image: OnboardingTutorialString.libraryHomepageImages[index])
                tutorials.append(tutorial)
            }
        }
        return tutorials
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: OnboardingTutorialData, rhs: OnboardingTutorialData) -> Bool {
        return lhs.id == rhs.id
    }
}


