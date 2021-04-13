//
//  ContentView.swift
//  Landmarks
//
//  Created by seunghwan Lee on 2021/04/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
                .ignoresSafeArea(edges: .top) // 화면의 상단 가장자리까지 확대 (safeArea 무시)
                .frame(height: 300) // width 생략시 뷰 width에 맞춰짐
            
            CircleImage()
                .offset(y: -130) // y축 기준 -130 offset
                .padding(.bottom, -130) // 뷰 하단을 기준으로 -130만큼 패딩 지정
         
            VStack(alignment: .leading) {
                Text("Turtle Rock")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.green)
                HStack {
                    Text("Joshua Tree National Park")
                        .font(.subheadline)
                    Spacer()
                    Text("California")
                        .font(.subheadline)
                }
                .font(.subheadline) // HStack 내부 전체에 해당 폰트 적용
                .foregroundColor(.secondary) // HStack 내부 전체에 해당 컬러 적용
                
                Divider() // 구분선 추가
                
                // 부가 설명 추가
                Text("About Turtle Rock")
                    .font(.title2)
                Text("Descriptive text goes here.")
            }
            .padding()
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
