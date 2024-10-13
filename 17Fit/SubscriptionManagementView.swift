//
//  SubscriptionManagementView.swift
//  17Fit
//
//  Created by 游哲維 on 2024/10/13.
//

import Foundation
import SwiftUI

struct SubscriptionManagementView: View {
    @State private var selectedSubscription = "訂閱中" // 預設為 "訂閱中"

    var body: some View {
        VStack {
            // 下拉菜單選擇器
            HStack {
                Spacer()

                Menu {
                    Button(action: {
                        selectedSubscription = "訂閱中"
                    }) {
                        Text("訂閱中")
                    }

                    Button(action: {
                        selectedSubscription = "已過期"
                    }) {
                        Text("已過期")
                    }
                } label: {
                    HStack {
                        Text(selectedSubscription)
                            .padding()
                            .foregroundColor(.gray) // 設定文字顏色為灰色
                        
                        Image(systemName: "chevron.down")
                            .padding(.trailing, 16)
                            .foregroundColor(.black) // 設定下拉箭頭顏色為黑色
                    }
                    .background(Color.white) // 背景白色
                    .cornerRadius(8) // 圓角
                }
            }
            .padding(.vertical, 8)
            .cornerRadius(8)
            .padding(.horizontal)

            Spacer()

            Text("尚無訂閱項目")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 20)

            Spacer()
        }
        .background(Color.gray.opacity(0.2))
        .navigationTitle("訂閱管理")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SubscriptionManagementView()
}
