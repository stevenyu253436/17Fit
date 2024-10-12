//
//  ExploreView.swift
//  17Fit
//
//  Created by 游哲維 on 2024/10/13.
//

import Foundation
import SwiftUI
import MapKit

struct ExploreView: View {
    var categoryName: String
    @State private var showMap = false // 控制地圖的顯示狀態
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 24.8138, longitude: 120.9675), // 新竹市中心坐標
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) // 地圖縮放比例
    )

    var body: some View {
        VStack(alignment: .leading) {
            // 搜索欄和地圖按鈕
            HStack {
                TextField("\(categoryName)", text: .constant(""))
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.leading, 16)
                
                // 顯示切換按鈕
                Button(action: {
                    showMap.toggle() // 點擊後切換地圖和列表視圖
                }) {
                    HStack {
                        Image(systemName: showMap ? "list.bullet" : "map") // 根據 showMap 狀態顯示不同圖標
                        Text(showMap ? "清單" : "地圖") // 根據 showMap 狀態顯示不同文字
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                }
                .padding(.trailing, 16)
            }
            .padding(.top, 20)
            
            if showMap {
                // 顯示地圖
                Map(coordinateRegion: $region)
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Make the map fill the available space
                    .edgesIgnoringSafeArea(.all) // Optional: remove padding from edges
            } else {
                // 商家卡片
                ScrollView {
                    VStack(spacing: 16) {
                        if categoryName == "運動健身" {
                            ShopCardView(shopName: "浪斯邦尼運動教室", distance: "0.21km", rating: "9.6")
                            ShopCardView(shopName: "BRÍO SPORT", distance: "0.63km", rating: "10.0")
                            ShopCardView(shopName: "LEIDY DANCE x FITNESS", distance: "1.2km", rating: "9.8")
                        } else {
                            // Add more categories if needed
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .navigationTitle(categoryName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ShopCardView: View {
    var shopName: String
    var distance: String
    var rating: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "photo") // 用商家圖片替代
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .cornerRadius(8)
            
            Text(shopName)
                .font(.headline)
                .padding(.top, 8)
            
            HStack {
                Text(distance)
                Spacer()
                Text("★ \(rating)")
            }
            .font(.subheadline)
            .foregroundColor(.gray)
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
        .padding(.vertical, 8)
    }
}

#Preview {
    ExploreView(categoryName: "運動健身")
}
