
import SwiftUI
struct OnboardingTutorialView: View {
    @Environment(\.presentationMode) var presentationMode
    var data: OnboardingTutorialData
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Image(data.image ?? "Text")
                    .resizable()
                    .scaledToFit()
                    .offset(x: 0, y: 150)
            }
            
            Spacer()
            
            Text(data.title)
                .font(.title2)
                .bold()
                .foregroundColor(Color(red: 41 / 255, green: 52 / 255, blue: 73 / 255))
            
            Text(data.subtitle)
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 250)
                .foregroundColor(Color(red: 237 / 255, green: 203 / 255, blue: 150 / 255))
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 2, y: 2)
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text(OnboardingConstant.getStartedString)
                        .font(.headline)
                        .foregroundColor(Color(OnboardingConstant.dossierBlue))
                        .padding(.horizontal, 50)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.white)
                        )
                })
                .shadow(radius: 10)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text(OnboardingConstant.skipString)
                        .font(.headline)
                        .foregroundColor(Color(OnboardingConstant.dossierBlue))
                        .padding(.horizontal, 50)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.white)
                        )
                })
                .shadow(radius: 10)
            }
        }
        Spacer()
        Spacer()
    }
}
