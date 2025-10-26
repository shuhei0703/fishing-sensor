//
//  Untitled.swift
//  test sound
//
//  Created by 齋藤秀平 on 2025/02/13.
//

import SwiftUI
import GoogleMobileAds

let adUnitID = "ca-app-pub-7266216351091418/1452523367"

struct AdBannerView: UIViewRepresentable {
    let adUnitID: String

    func makeUIView(context: Context) -> BannerView {
        let bannerView = BannerView(adSize: AdSizeBanner)
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first?.rootViewController
        bannerView.delegate = context.coordinator
        bannerView.load(Request()) // ここを修正
        return bannerView
    }

    func updateUIView(_ uiView: BannerView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator: NSObject, BannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("✅ Ad received successfully!")
        }

        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            print("❌ Failed to receive ad: \(error.localizedDescription)")
        }
    }
}
