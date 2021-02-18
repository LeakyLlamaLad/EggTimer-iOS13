//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft" : /*300*/5,
                    "Medium" : /*420*/7,
                    "Hard" : /*720*/12]
    
    var timer = Timer()
    var totalTime = 0
    var secondsPast = 0
    var hardness:String?
    var player: AVAudioPlayer!

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var mainLable: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {

        timer.invalidate()
        hardness = sender.currentTitle
        mainLable.text = "Cooking..."
        progressBar.progress = 0
        totalTime = eggTimes[hardness!]!
        secondsPast = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    
    }

    @objc func onTimerFires()
    {
        secondsPast += 1
        let percentageProgress = Float(secondsPast) / Float(totalTime)
        
        progressBar.progress = percentageProgress

        if secondsPast == totalTime {
            timer.invalidate()
            totalTime = 0
            secondsPast = 0
            mainLable.text = "Done!"
            playSound(soundName: "alarm_sound")
        }
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
