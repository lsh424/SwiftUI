//
//  CategoryRow.swift
//  Landmarks
//
//  Created by seunghwan Lee on 2021/04/20.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Landmark]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { landmark in
                        NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                            CategoryItem(landmark: landmark)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var landmarks = ModelData().landmarks
    
    // 배열.prefix -> 배열의 3번째 까지 반환
    static var previews: some View {
        CategoryRow(
            categoryName: landmarks[0].category.rawValue, items: Array(landmarks.prefix(4))
        )
    }
}
