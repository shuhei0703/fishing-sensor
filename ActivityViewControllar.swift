//
//  View.swift
//  test sound
//
//  Created by 齋藤秀平 on 2024/10/13.
//

import SwiftUI
import UIKit

// ShareSheetの名前を変更（例: FileShareSheet）
struct FileShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

