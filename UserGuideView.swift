//
//  UserGuideView.swift
//  test sound
//
//  Created by 齋藤秀平 on 2025/03/01.
//

import SwiftUI
import PDFKit

struct UserGuideView: View {
    @Environment(\.presentationMode) var presentationMode  // シートを閉じるための環境変数
    
    var body: some View {
        NavigationView {  // NavigationView でツールバーを有効化
            VStack {
                if let pdfURL = Bundle.main.url(forResource: "user_guide", withExtension: "pdf") {
                    PDFKitView(url: pdfURL)
                } else {
                    Text("PDFファイルが見つかりません。")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("使用方法")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {  // 📌 右上に「閉じる」ボタン
                    Button("閉じる") {
                        ButtonSoundPlayer.shared.play(soundName: "click2") // 🔊 サウンド再生
                        presentationMode.wrappedValue.dismiss()  // シートを閉じる
                    }
                }
            }
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}
