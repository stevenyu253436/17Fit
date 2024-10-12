//
//  _7FitApp.swift
//  17Fit
//
//  Created by 游哲維 on 2024/10/12.
//

import SwiftUI

@main
struct _7FitApp: App {
    init() {
        // Set the appearance for the navigation bar globally
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
