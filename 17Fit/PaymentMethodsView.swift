//
//  PaymentMethodsView.swift
//  17Fit
//
//  Created by 游哲維 on 2024/10/13.
//

import Foundation
import SwiftUI

// 模擬 "管理付款方式" 頁面
struct PaymentMethodsView: View {
    var body: some View {
        VStack {
            Spacer()

            Button(action: {
                // 新增付款方式的操作
            }) {
                Text("新增付款方式")
                    .font(.headline)
                    .foregroundColor(.blue) // 將文字設置為藍色
                    .padding()
                    .frame(width: 300)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20) // 設置圓角
                            .stroke(Color.blue, lineWidth: 2) // 設置邊框為藍色
                    )
            }
        }
        .navigationTitle("管理付款方式")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 添加 Preview
#Preview {
    PaymentMethodsView()
}
