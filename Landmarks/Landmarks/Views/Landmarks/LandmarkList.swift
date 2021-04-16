//
//  LandmarkList.swift
//  Landmarks
//
//  Created by seunghwan Lee on 2021/04/14.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    
    var body: some View {
        NavigationView {
            // 정적 + 동적 뷰 혹은 둘 이상의 동적 뷰를 결합하려면 데이터 컬렉션을 리스트로 전달하는 대신 Foreach 사용
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favortie only")
                }
                
                
                ForEach(filteredLandmarks) {  landmark in
                    NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            LandmarkList()
                .environmentObject(ModelData())
        }
    }
}
