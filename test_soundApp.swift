//
//  test_soundApp.swift
//  test sound
//
//  Created by 齋藤秀平 on 2024/10/09.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport
import GoogleMobileAds
// import StoreKit   // ← 削除

@main
struct test_soundApp: App {
    @StateObject private var languageManager = AppLanguageManager()
    // @StateObject private var subManager = SubscriptionManager.shared   // ← 削除

    init() {
        MobileAds.shared.start(completionHandler: nil)
        requestTrackingPermission()
    }

    var body: some Scene {
        WindowGroup {
            AccelerometerView()
                .environmentObject(languageManager)
                // .environmentObject(subManager) // ← 削除
        }
    }

    // そのままでOK
    private func requestTrackingPermission() {
        if #available(iOS 14, *) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .authorized:
                        print("✅ トラッキング許可されました")
                    case .denied:
                        print("❌ トラッキング拒否されました")
                    case .notDetermined:
                        print("⏳ トラッキング未選択")
                    case .restricted:
                        print("🚫 トラッキングが制限されています")
                    @unknown default:
                        break
                    }
                }
            }
        }
    }
}
