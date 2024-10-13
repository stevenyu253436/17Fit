//
//  MyAppointmentsView.swift
//  17Fit
//
//  Created by 游哲維 on 2024/10/13.
//

import Foundation
import SwiftUI

struct MyAppointmentsView: View {
    @State private var selectedTab: Int = 0 // State to track selected tab
    // 假設這是所有的預約資料
    var upcomingAppointments = [
        Appointment(date: "2024/10/15", dayOfWeek: "周二", time: "15:30", courseName: "一對一私人健身教練課程", coachName: "喬安_Billy 教練", location: "Lifelab 體能空間"),
        Appointment(date: "2024/10/17", dayOfWeek: "周四", time: "15:30", courseName: "一對一私人健身教練課程", coachName: "喬安_Billy 教練", location: "Lifelab 體能空間")
    ]
    
    var completedAppointments = [
        Appointment(date: "2024/09/21", dayOfWeek: "周六", time: "16:10", courseName: "一對一私人健身教練課程", coachName: "喬安_Billy 教練", location: "Lifelab 體能空間"),
        Appointment(date: "2024/09/10", dayOfWeek: "周二", time: "15:30", courseName: "一對一私人健身教練課程", coachName: "喬安_Billy 教練", location: "Lifelab 體能空間"),
        Appointment(date: "2024/09/06", dayOfWeek: "周五", time: "15:30", courseName: "教練體驗課", coachName: "喬安_Billy 教練", location: "Lifelab 體能空間")
    ]

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    selectedTab = 0
                }) {
                    Text("即將到來")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selectedTab == 0 ? .black : .gray) // Highlight selected tab
                }
                
                Button(action: {
                    selectedTab = 1
                }) {
                    Text("候補中")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selectedTab == 1 ? .black : .gray) // Highlight selected tab
                }

                Button(action: {
                    selectedTab = 2
                }) {
                    Text("已經完成")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(selectedTab == 2 ? .black : .gray) // Highlight selected tab
                }
            }
            .padding(.vertical, 10)
            
            if selectedTab == 0 {
                ScrollView {
                    ForEach(upcomingAppointments, id: \.date) { appointment in
                        AppointmentRow(appointment: appointment)
                            .padding(.horizontal, 20)
                    }
                }
            } else if selectedTab == 1 {
                
            } else if selectedTab == 2 {
                // 已經完成
                ScrollView {
                    ForEach(completedAppointments, id: \.date) { appointment in
                        AppointmentRow(appointment: appointment)
                            .padding(.horizontal, 20)
                    }
                }
            }
            
            Spacer()
        }
        .navigationTitle("我的預約")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AppointmentRow: View {
    var appointment: Appointment

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(appointment.date), \(appointment.dayOfWeek) , \(appointment.time)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(appointment.courseName)
                .font(.headline)
                .padding(.vertical, 2)
            
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text(appointment.coachName)
                    Text(appointment.location)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                Spacer()
                Button(action: {
                    // 執行取消操作
                }) {
                    Text("取消")
                        .font(.subheadline)
                        .frame(width: 60, height: 30)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.bottom, 10)
    }
}

struct Appointment: Identifiable {
    var id = UUID()
    var date: String
    var dayOfWeek: String
    var time: String
    var courseName: String
    var coachName: String
    var location: String
}

#Preview {
    MyAppointmentsView()
}
