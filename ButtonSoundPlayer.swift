//
//  ButtonSoundPlayer.swift
//  test sound
//
//  Created by 齋藤秀平 on 2025/07/16.
//

import AVFoundation

class ButtonSoundPlayer {
    static let shared = ButtonSoundPlayer()
    private var players: [String: AVAudioPlayer] = [:]

    private init() {
        preloadSounds()
    }

    private func preloadSounds() {
        let soundNames = ["click1", "click2", "click3", "click4"] // ここに使うファイル名を列挙

        for name in soundNames {
            if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
                do {
                    let player = try AVAudioPlayer(contentsOf: url)
                    player.prepareToPlay()
                    players[name] = player
                } catch {
                    print("🔊 Error loading sound \(name): \(error)")
                }
            } else {
                print("🔊 Sound file \(name).mp3 not found.")
            }
        }
    }

    func play(soundName: String) {
        guard let player = players[soundName] else {
            print("🔊 No player for \(soundName)")
            return
        }
        player.stop()
        player.currentTime = 0
        player.play()
    }
}
