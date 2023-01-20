
import SwiftUI
struct OnboardingTutorialScrollView: View {
    @State private var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab,
                content: {
                            ForEach(OnboardingTutorialData.getDataFor(type: .landing)) { viewData in
                                OnboardingTutorialView(data: viewData)
                                    .tag(viewData.id)
                            }
                        })
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct OnboardingTutorialScrollView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTutorialScrollView()
    }
}
