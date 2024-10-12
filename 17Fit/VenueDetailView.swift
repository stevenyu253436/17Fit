//
//  VenueDetailView.swift
//  17Fit
//
//  Created by 游哲維 on 2024/10/13.
//

import Foundation
import SwiftUI

// VenueDetailView 的範例
struct VenueDetailView: View {
    @Binding var showVenueDetail: Bool // 控制返回主頁面
    
    var venueName: String
    var venueAddress: String
    var imageUrl: String // Venue image URL
    
    var body: some View {
        VStack {
            HStack {
                // 圖片顯示部分
                Image(systemName: "building.2.crop.circle") // 替換為實際的圖片
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding()
                
                // 場館名稱和地址
                VStack(alignment: .leading, spacing: 10) {
                    Text(venueName)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    
                    Text(venueAddress)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                
                // 預約按鈕
                Button(action: {
                    // 處理預約邏輯
                }) {
                    Text("預約")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 20)
            }
            
            Spacer()
        }
        .navigationTitle("我的場館")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

#Preview {
    VenueDetailView(showVenueDetail: .constant(true), venueName: "Lifelab 體能空間", venueAddress: "新竹市東區慈雲路 97 號", imageUrl: "")
}
