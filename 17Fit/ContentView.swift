//
//  ContentView.swift
//  17Fit
//
//  Created by 游哲維 on 2024/10/12.
//

import SwiftUI

struct ContentView: View {
    @State private var isSidebarVisible = false // State to control sidebar visibility
    @State private var showActionSheet = false
    @State private var selectedLocation = "探索附近"
    @State private var searchText = ""
    @State private var showVenueDetail = false // State to control showing the venue detail
    @State private var showFeedbackPopup = false // 控制評論彈窗的顯示
    @State private var showLanguagePopup = false // 控制語言選擇彈窗的顯示
    @State private var navigateToAppointments = false // 用來控制導航到 MyAppointmentsView
    @State private var navigateToAccount = false // 控制是否導航到 MyAccountView
    @State private var selectedTabForAccount = 1 // 控制進入 MyAccountView 時的 Tab 預設值

    var body: some View {
        ZStack {
            // Main Content
            NavigationView {
                if navigateToAppointments {
                    // 導航到 MyAppointmentsView
                    MyAppointmentsView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(leading: Button(action: {
                            withAnimation {
                                isSidebarVisible.toggle() // 切換側邊欄顯示
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                        })
                } else if navigateToAccount {
                    // 導航到 MyAccountView
                    MyAccountView(selectedTab: $selectedTabForAccount)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(leading: Button(action: {
                            withAnimation {
                                isSidebarVisible.toggle() // 切換側邊欄顯示
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                        })
                } else if showVenueDetail {
                    // 顯示「我的場館」詳細頁面
                    VenueDetailView(showVenueDetail: $showVenueDetail, venueName: "Lifelab 體能空間", venueAddress: "新竹市東區慈雲路 97 號", imageUrl: "your_image_url_here")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(leading: Button(action: {
                            withAnimation {
                                isSidebarVisible.toggle() // Toggle sidebar visibility
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                        })
                } else {
                    ScrollView {
                        VStack {
                            // Section Header (e.g., "探索附近" with Chevron)
                            VStack(alignment: .center, spacing: 5) {
                                ActionButtonView(selectedLocation: $selectedLocation, showActionSheet: $showActionSheet)
                                
                                Text("尋找你附近的商家，購買獨家體驗方案！")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.top, 20)
                            .padding(.horizontal)
                            
                            // Search Bar
                            SearchBarView(searchText: $searchText)

                            // Categories (運動健身, 美容舒壓)
                            HStack(spacing: 20) {
                                CategoryView(title: "運動健身", color: Color.blue, destinationView: AnyView(ExploreView(categoryName: "運動健身")))
                                CategoryView(title: "美容舒壓", color: Color.pink, destinationView: AnyView(ExploreView(categoryName: "美容舒壓")))
                            }
                            .padding(.horizontal)
                            .padding(.top, 20)
                            
                            // Favorite Venues Section
                            SectionHeaderView(title: "我的場館", actionTitle: "全部場館", showVenueDetail: $showVenueDetail)
                            FavoriteVenueView()
                            
                            // My Plans Section
                            SectionHeaderView(title: "我的方案", actionTitle: "全部方案", showVenueDetail: $showVenueDetail)
                            MyPlanView()
                            
                            Spacer()
                        }
                        .padding(.top, 10)
                    }
                    .navigationTitle("首頁")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: Button(action: {
                        withAnimation {
                            isSidebarVisible.toggle() // Toggle sidebar visibility
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    })
                }
            }
            
            // Sidebar menu
            SidebarView(isSidebarVisible: $isSidebarVisible,
                        showVenueDetail: $showVenueDetail,
                        showLanguagePopup: $showLanguagePopup,
                        showFeedbackPopup: $showFeedbackPopup,
                        navigateToAppointments: $navigateToAppointments,
                        selectedTabForAccount: $selectedTabForAccount, // 新增這兩個參數
                        navigateToAccount: $navigateToAccount)
                .offset(x: isSidebarVisible ? 0 : -UIScreen.main.bounds.width) // 側邊欄移除屏幕
                .animation(.easeInOut(duration: 0.3), value: isSidebarVisible)
                .zIndex(1)
            
            // 評論彈窗
            if showFeedbackPopup {
                ZStack {
                    Color.black.opacity(0.3) // 半透明背景
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("你覺得 17FIT 如何？")
                            .font(.title2)
                            .padding()

                        Text("給予評論或回饋意見，協助我們創造更好的體驗")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 10)

                        Button(action: {
                            // 處理 "我喜歡" 按鈕
                            showFeedbackPopup = false
                        }) {
                            Text("很好，我喜歡!")
                                .font(.headline)
                                .padding()
                                .frame(width: 200)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                        Button(action: {
                            // 處理 "我遇到問題" 按鈕
                            showFeedbackPopup = false
                        }) {
                            Text("我遇到問題")
                                .font(.headline)
                                .padding()
                                .frame(width: 200)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                        Button(action: {
                            // 關閉彈窗
                            showFeedbackPopup = false
                        }) {
                            Text("取消")
                                .font(.headline)
                                .padding()
                                .frame(width: 200)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                }
                .zIndex(3) // 確保在最上層
            }

            // 語言選擇彈窗
            if showLanguagePopup {
                ZStack {
                    Color.black.opacity(0.3) // 半透明背景
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("請選擇語言")
                            .font(.title2)
                            .padding()

                        Button(action: {
                            // Handle 繁體中文選擇
                            showLanguagePopup = false
                        }) {
                            Text("繁體中文")
                                .font(.headline)
                                .padding()
                                .frame(width: 200)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                        Button(action: {
                            // Handle English 選擇
                            showLanguagePopup = false
                        }) {
                            Text("English")
                                .font(.headline)
                                .padding()
                                .frame(width: 200)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                        Button(action: {
                            // 關閉彈窗
                            showLanguagePopup = false
                        }) {
                            Text("取消")
                                .font(.headline)
                                .padding()
                                .frame(width: 200)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                }
                .zIndex(2) // 確保在最上層
            }
        }
    }
}

// 搜尋框的重構
struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("搜尋店家", text: $searchText)
                .padding(.leading, 16)
                .frame(height: 40)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
                .padding(.top, 20)
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.trailing, 20)
        }
    }
}

// ActionSheet按鈕的重構
struct ActionButtonView: View {
    @Binding var selectedLocation: String
    @Binding var showActionSheet: Bool
    
    var body: some View {
        Button(action: {
            showActionSheet = true
        }) {
            HStack {
                Text(selectedLocation)
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                
                Image(systemName: "chevron.down")
                    .foregroundColor(.blue)
            }
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("選擇地點"),
                message: Text("請選擇一個地點"),
                buttons: locationButtons
            )
        }
    }
    
    private var locationButtons: [ActionSheet.Button] {
        [
            .default(Text("目前附近位置")) { selectedLocation = "目前附近位置" },
            .default(Text("大台北")) { selectedLocation = "大台北" },
            .default(Text("桃園")) { selectedLocation = "桃園" },
            .default(Text("新竹")) { selectedLocation = "新竹" },
            .default(Text("台中")) { selectedLocation = "台中" },
            .default(Text("台南|高雄")) { selectedLocation = "台南|高雄" },
            .cancel(Text("取消"))
        ]
    }
}

// Custom reusable view for categories
struct CategoryView: View {
    var title: String
    var color: Color
    var destinationView: AnyView
    
    var body: some View {
        NavigationLink(destination: destinationView) {
            VStack {
                Image(systemName: "square.grid.2x2.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding()
                    .background(color.opacity(0.3))
                    .cornerRadius(12)
                    .foregroundColor(color) // 指定前景顏色
                
                Text(title)
                    .font(.headline)
                    .padding(.top, 8)
                    .foregroundColor(.primary)
            }
            .frame(width: 150, height: 150)
            .background(color.opacity(0.1))
            .cornerRadius(16)
        }
    }
}

// Section Header with a navigation option to see all
struct SectionHeaderView: View {
    var title: String
    var actionTitle: String
    @Binding var showVenueDetail: Bool // 接受來自 ContentView 的綁定變數

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.leading, 16)
            
            Spacer()
            
            Button(action: {
                // Action for "全部場館" or "全部方案"
                if actionTitle == "全部場館" {
                    showVenueDetail = true
                } else {
                    
                }
            }) {
                HStack {
                    Text(actionTitle)
                        .foregroundColor(.blue)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue) // Match the color with the text
                }
            }
            .padding(.trailing, 16)
        }
        .padding(.vertical, 10)
    }
}

// Favorite Venue Sample
struct FavoriteVenueView: View {
    var body: some View {
        HStack {
            Image(systemName: "building.2.crop.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding(8)
                .background(Color.green.opacity(0.2))
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text("Lifelab體能空間")
                    .font(.headline)
                Text("瑜伽與體能訓練")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 8)
            
            Spacer()
            
            Button(action: {
                // Go to all venues
            }) {
                Text("查看詳情")
                    .foregroundColor(.blue)
            }
            .padding(.trailing, 16)
        }
        .frame(height: 80)
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal)
        .shadow(radius: 3)
    }
}

// My Plan Sample
struct MyPlanView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Life lab體能空間")
                    .font(.headline)
                Text("(48堂)教練課程")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("剩餘: 46次")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            .padding(.leading, 16)
            
            Spacer()
            
            VStack {
                Text("到期日:2026-08-27")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 16)
        }
        .frame(height: 80)
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal)
        .shadow(radius: 3)
    }
}

struct SidebarView: View {
    @Binding var isSidebarVisible: Bool
    @Binding var showVenueDetail: Bool // 新增此綁定來控制顯示場館詳情
    @Binding var showLanguagePopup: Bool // 接受來自 ContentView 的綁定變數
    @Binding var showFeedbackPopup: Bool // 控制評論彈窗
    @Binding var navigateToAppointments: Bool // 控制導航的綁定變數
    @Binding var selectedTabForAccount: Int // 接收要導航到的初始 selectedTab
    @Binding var navigateToAccount: Bool

    var body: some View {
        VStack(alignment: .leading) {
            // User profile at the top
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.leading, 16)
                
                Text("游哲維")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.leading, 8)
            }
            .padding(.vertical, 24)
            
            Divider()
            
            // Menu items
            List {
                // Home button to close the sidebar and go back to main content
                Button(action: {
                    withAnimation {
                        isSidebarVisible = false // Close the sidebar
                        showVenueDetail = false // Show venue detail page
                        navigateToAppointments = false // 確保返回主頁
                        navigateToAccount = false // 確保返回主頁時不會導航到 MyAccountView
                    }
                }) {
                    Label("首頁", systemImage: "house.fill")
                }

                Button(action: {
                    withAnimation {
                        isSidebarVisible = false
                        navigateToAppointments = true // 導航到 MyAppointmentsView
                        navigateToAccount = false // 確保不會導航到 MyAccountView
                    }
                }) {
                    Label("我的預約", systemImage: "calendar")
                }

                Button(action: {
                    withAnimation {
                        isSidebarVisible = false
                        navigateToAppointments = false // 確保不顯示我的預約頁面
                        selectedTabForAccount = 2 // 方案 Tab
                        navigateToAccount = true
                    }
                }) {
                    Label("我的方案", systemImage: "doc.text")
                }

                Button(action: {
                    withAnimation {
                        isSidebarVisible = false
                        navigateToAppointments = false // 確保不顯示我的預約頁面
                        selectedTabForAccount = 1 // 帳戶 Tab
                        navigateToAccount = true
                    }
                }) {
                    Label("我的帳戶", systemImage: "gearshape.fill")
                }

                Button(action: {
                    withAnimation {
                        isSidebarVisible = false
                        showVenueDetail = true // Show venue detail page
                        navigateToAppointments = false // 確保不顯示我的預約頁面
                        navigateToAccount = false // 確保不會導航到 MyAccountView
                    }
                }) {
                    Label("我的場館", systemImage: "heart.fill")
                }
                
                Button(action: {
                    showFeedbackPopup = true // 顯示評論彈窗
                }) {
                    Label("評論&意見", systemImage: "star.fill")
                }
                
                Button(action: {
                    showLanguagePopup = true
                }) {
                    Label("語言", systemImage: "globe")
                }
            }
            .listStyle(InsetListStyle())
            
            Spacer()
        }
        .frame(width: 250) // Sidebar width
        .background(Color.white)
        .shadow(radius: 5)
        .edgesIgnoringSafeArea(.vertical)
    }
}

// Example destination views
struct HomeView: View { var body: some View { Text("Home View") } }
struct MyFavoritesView: View { var body: some View { Text("My Favorites") } }
struct FeedbackView: View { var body: some View { Text("Feedback") } }
struct LanguageSettingsView: View { var body: some View { Text("Language Settings") } }

#Preview {
    ContentView()
}
