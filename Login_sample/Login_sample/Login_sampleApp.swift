//
//  Login_sampleApp.swift
//  Login_sample
//
//  Created by a2lab on 2026/02/14.
//

import SwiftUI
import SwiftData
import FirebaseCore

@main
struct YourApp: App {
    // Firebaseの初期化
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
