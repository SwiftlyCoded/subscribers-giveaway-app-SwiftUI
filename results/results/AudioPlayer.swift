//
//  soundPlayer.swift
//  GolfApp1.0
//
//  Created by Alex on 11/02/2020.
//  Copyright © 2020 Alexandr Čížek. All rights reserved.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func play(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
            print("Playing \(sound)!")
        }
        
        catch{
            print("Error: Couldn't play \(sound)!")
        }
    }
}
