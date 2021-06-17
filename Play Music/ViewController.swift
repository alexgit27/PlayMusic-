//
//  ViewController.swift
//  Play Music
//
//  Created by Alexandr on 19.01.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var songToPlay = 0
    var hasBeenPaused = false
    var musicPlayer = AVAudioPlayer()
    var musicArray: [String] = ["Time", "Sparrow", "First"]
    var imagesArray: [String] = ["time", "sparrow", "first"]
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareSongAndSession(index: songToPlay)
        
        songLabel.text = musicArray[songToPlay]
        
        imageView.image = UIImage(imageLiteralResourceName: imagesArray[songToPlay])
        
        currentTimeLabel.text = "Time: \(((musicPlayer.duration) / 60.0).rounded(digits: 1))"
    }
    
    func prepareSongAndSession(index: Int){
        do {
            musicPlayer =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "\(musicArray[index])", ofType: "mp3")!))
            musicPlayer.prepareToPlay()
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.playback)
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: IBAction's
    @IBAction func previousButton(_ sender: UIButton) {
        songToPlay -= 1
        if songToPlay < 0{
            songToPlay = 2
            prepareSongAndSession(index: songToPlay)
            songLabel.text = musicArray[songToPlay]
            imageView.image = UIImage(imageLiteralResourceName: imagesArray[songToPlay])
            musicPlayer.play()
            currentTimeLabel.text = "Time: \(((musicPlayer.duration) / 60.0).rounded(digits: 1))"
        } else{
            prepareSongAndSession(index: songToPlay)
            songLabel.text = musicArray[songToPlay]
            imageView.image = UIImage(imageLiteralResourceName: imagesArray[songToPlay])
            currentTimeLabel.text = "Time: \(((musicPlayer.duration) / 60.0).rounded(digits: 1))"
        }
        
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        songToPlay += 1
        if songToPlay == 3{
            songToPlay = 0
            prepareSongAndSession(index: songToPlay)
            musicPlayer.play()
            songLabel.text = musicArray[songToPlay]
            imageView.image = UIImage(imageLiteralResourceName: imagesArray[songToPlay])
            currentTimeLabel.text = "Time: \(((musicPlayer.duration) / 60.0).rounded(digits: 1))"
        } else{
            prepareSongAndSession(index: songToPlay)
            musicPlayer.play()
            songLabel.text = musicArray[songToPlay]
            imageView.image = UIImage(imageLiteralResourceName: imagesArray[songToPlay])
            currentTimeLabel.text = "Time: \(((musicPlayer.duration) / 60.0).rounded(digits: 1))"
        }
        
    }
    
    @IBAction func restartButton(_ sender: UIButton) {
        if musicPlayer.isPlaying || hasBeenPaused{
            musicPlayer.stop()
            musicPlayer.currentTime = 0
            musicPlayer.play()
        } else{
            musicPlayer.play()
        }
    }
    
    @IBAction func playButton(_ sender: UIButton) {
        musicPlayer.play()
    }
    @IBAction func pauseButton(_ sender: UIButton) {
        if let data = musicPlayer.data{
            print(data)
        }
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            hasBeenPaused = true
        } else{
            hasBeenPaused = false
        }
    }
}

