//
//  LandmarkDetail.swift
//  SwiftUITutorialApple
//
//  Created by Amar Gawade on 9/9/23.
//

import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var modelData: ModelData
    var landmark: Landmark
    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)

            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                        .accessibilityIdentifier($modelData.landmarks[landmarkIndex].isFavorite.wrappedValue ?
                                                 AppAccessibilityIdentifiers.landmarkDetailsFavoriteButton :
                                                    AppAccessibilityIdentifiers.landmarkDetailsNotFavoriteButton)
                }

                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                Text("About \(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
            }
            .padding()
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct LandmarkDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        // LandmarkDetail(landmark: landmarks[0])
//        LandmarkDetail(landmark: ModelData().landmarks[0])
//    }
//}

struct LandmarkDetail_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        LandmarkDetail(landmark: modelData.landmarks[0])
            .environmentObject(modelData)
    }
}
