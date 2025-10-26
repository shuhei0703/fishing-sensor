//
//  Settings.swift
//  test sound
//
//  Created by 齋藤秀平 on 2024/12/22.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: AccelerometerViewModel
    @EnvironmentObject var languageManager: AppLanguageManager
    @State private var selectedLanguage: String

    init(viewModel: AccelerometerViewModel) {
        self.viewModel = viewModel
        self._selectedLanguage = State(initialValue: viewModel.currentLanguage)
    }

    var body: some View {
        NavigationView {
            Form {
                // 言語設定
                Section(header: Text(languageManager.localizedString(for: "language"))) {
                    Picker(languageManager.localizedString(for: "language"), selection: $selectedLanguage) {
                        ForEach(["日本語", "English"], id: \.self) { language in
                            Text(language)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                // 音量設定
                Section(header: Text(languageManager.localizedString(for: "volume"))) {
                    Slider(value: $viewModel.audioVolume, in: 0.0...1.0) {
                        Text(languageManager.localizedString(for: "volume"))
                    }
                    .accentColor(.blue)
                    Text("\(languageManager.localizedString(for: "currentVolume")): \(Int(viewModel.audioVolume * 100))%")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                // 画面の明るさ設定
                /*Section(header: Text(languageManager.localizedString(for: "brightness"))) {
                    Slider(value: $viewModel.screenBrightness, in: 0.1...1.0) {
                        Text(languageManager.localizedString(for: "brightness"))
                    }
                    .accentColor(.yellow)
                    Text("\(languageManager.localizedString(for: "currentBrightness")): \(Int(viewModel.screenBrightness * 100))%")
                        .font(.caption)
                        .foregroundColor(.gray)
                }*/

                // ファイル保存ボタンの表示/非表示設定
                Section(header: Text(languageManager.localizedString(for: "fileSaveOption"))) {
                    Toggle(languageManager.localizedString(for: "showFileSaveButton"), isOn: $viewModel.isFileSaveButtonVisible)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
            }
            .navigationTitle(languageManager.localizedString(for: "settings"))
            .navigationBarItems(trailing: Button(action: {
                ButtonSoundPlayer.shared.play(soundName: "click2")
                viewModel.applySettings(language: selectedLanguage)
                languageManager.currentLanguage = selectedLanguage
            }) {
                Text(languageManager.localizedString(for: "apply"))
            })
        }
    }
}
