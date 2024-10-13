//
//  MyAccountView.swift
//  17Fit
//
//  Created by 游哲維 on 2024/10/13.
//

import Foundation
import SwiftUI

struct MyAccountView: View {
    @State var selectedTab: Int // 接收初始 selectedTab 值

    var body: some View {
        VStack {
            // Tabs for 設定 and 通知
            HStack {
                Button(action: {
                    selectedTab = 0
                }) {
                    Text("設定")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selectedTab == 0 ? .black : .gray)
                }
                .padding(.vertical, 8)
                
                Button(action: {
                    selectedTab = 1
                }) {
                    Text("通知")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selectedTab == 1 ? .black : .gray)
                }
                .padding(.vertical, 8)
                
                Button(action: {
                    selectedTab = 2
                }) {
                    Text("方案")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selectedTab == 2 ? .black : .gray)
                }
                .padding(.vertical, 8)

            }
            .cornerRadius(8)
            .padding(.horizontal)
            
            // Content depending on selected tab
            if selectedTab == 0 {
                // 設定內容
                SettingsView()
            } else if selectedTab == 1 {
                // 通知內容
                NotificationsView()
            } else if selectedTab == 2 {
                PlansView()
            }
            
            Spacer()
        }
        .navigationTitle("我的帳戶")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // User Profile Picture and Name
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("游哲維")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Text("stevenyu.supreme@gmail.com")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Edit Button
                Button(action: {
                    // 編輯按鈕的操作
                }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.gray)
                }
                .padding(.trailing)
            }
            .padding()

            Divider() // 分隔線

            // 設定選項
            SettingsItemView(icon: "creditcard.fill", title: "管理付款方式")
            
            Divider()
            
            SettingsItemView(icon: "key.fill", title: "更改密碼")
            
            Divider()
            
            SettingsItemView(icon: "doc.text.fill", title: "訂閱管理")
            
            Divider()
            
            SettingsItemView(icon: "rectangle.portrait.and.arrow.right.fill", title: "登出")

            Spacer()
        }
        .navigationTitle("設定")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsItemView: View {
    var icon: String
    var title: String

    var body: some View {
        HStack {
            // Icon
            Image(systemName: icon)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.blue)
            
            // Title
            Text(title)
                .font(.headline)
            
            Spacer()
        }
        .padding(.vertical, 30)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(8)
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

struct NotificationsView: View {
    var body: some View {
        Spacer()
        
        Text("您目前無任何通知訊息")
            .font(.headline)
            .foregroundColor(.gray)
            .padding(.top, 20)
    }
}

// 方案頁面
struct PlansView: View {
    @State private var selectedSubTab = 0 // 0: 有效, 1: 無效
    
    var body: some View {
        VStack {
            // Tabs for 有效 and 無效
            HStack {
                Button(action: {
                    selectedSubTab = 0
                }) {
                    Text("有效")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selectedSubTab == 0 ? .black : .gray)
                        .padding(.vertical, 8)
                        .background(selectedSubTab == 0 ? Color.white : Color.clear) // 選中時顯示白底
                        .cornerRadius(8) // 圓角
                        .shadow(color: selectedSubTab == 0 ? Color.gray.opacity(0.5) : Color.clear, radius: 5, x: 0, y: 2) // 選中時顯示陰影
                }
                .padding(.vertical, 8)
                
                Button(action: {
                    selectedSubTab = 1
                }) {
                    Text("無效")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selectedSubTab == 1 ? .black : .gray)
                        .padding(.vertical, 8)
                        .background(selectedSubTab == 1 ? Color.white : Color.clear) // 選中時顯示白底
                        .cornerRadius(8) // 圓角
                        .shadow(color: selectedSubTab == 1 ? Color.gray.opacity(0.5) : Color.clear, radius: 5, x: 0, y: 2) // 選中時顯示陰影
                }
                .padding(.vertical, 8)
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal)
            
            // Content depending on selected sub-tab
            if selectedSubTab == 0 {
                // 有效方案
                ValidPlansView()
            } else {
                // 無效方案
                InvalidPlansView()
            }
            
            Spacer()
        }
    }
}

// 有效方案
struct ValidPlansView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Life lab 體能空間")
                    .font(.headline)
                
                Spacer()
                
                Text("剩餘: 44次")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
            HStack {
                Text("(48堂)教練課程")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("2024-09-06 ~ 2026-08-27")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            Spacer()
        }
    }
}

// 無效方案
struct InvalidPlansView: View {
    var body: some View {
        Text("目前沒有無效方案")
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding(.top, 20)
    }
}

#Preview {
    MyAccountView(selectedTab: 0)
}
