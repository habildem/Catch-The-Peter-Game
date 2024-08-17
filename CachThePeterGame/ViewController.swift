//
//  ViewController.swift
//  CachThePeterGame
//
//  Created by Habil Demirci on 5/8/24.
//

import UIKit

class ViewController: UIViewController {
    //Variables
    var timer = Timer()
    var score = 0
    var counter = 0
    var peterArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var peter1: UIImageView!
    @IBOutlet weak var peter2: UIImageView!
    @IBOutlet weak var peter3: UIImageView!
    @IBOutlet weak var peter4: UIImageView!
    @IBOutlet weak var peter5: UIImageView!
    @IBOutlet weak var peter6: UIImageView!
    @IBOutlet weak var peter7: UIImageView!
    @IBOutlet weak var peter8: UIImageView!
    @IBOutlet weak var peter9: UIImageView!
    @IBOutlet weak var peter10: UIImageView!
    @IBOutlet weak var peter11: UIImageView!
    @IBOutlet weak var peter12: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(score)"
        
        //Highscore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        //Images
        peter1.isUserInteractionEnabled = true
        peter2.isUserInteractionEnabled = true
        peter3.isUserInteractionEnabled = true
        peter4.isUserInteractionEnabled = true
        peter5.isUserInteractionEnabled = true
        peter6.isUserInteractionEnabled = true
        peter7.isUserInteractionEnabled = true
        peter8.isUserInteractionEnabled = true
        peter9.isUserInteractionEnabled = true
        peter10.isUserInteractionEnabled = true
        peter11.isUserInteractionEnabled = true
        peter12.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore ))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer10 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer11 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer12 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        peter1.addGestureRecognizer(recognizer1)
        peter2.addGestureRecognizer(recognizer2)
        peter3.addGestureRecognizer(recognizer3)
        peter4.addGestureRecognizer(recognizer4)
        peter5.addGestureRecognizer(recognizer5)
        peter6.addGestureRecognizer(recognizer6)
        peter7.addGestureRecognizer(recognizer7)
        peter8.addGestureRecognizer(recognizer8)
        peter9.addGestureRecognizer(recognizer9)
        peter10.addGestureRecognizer(recognizer10)
        peter11.addGestureRecognizer(recognizer11)
        peter12.addGestureRecognizer(recognizer12)
        
        
        peterArray = [peter1,peter2,peter3,peter4,peter4,peter5,peter6,peter7,peter8,peter9,peter10,peter11,peter12]
        
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector (countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidePeter), userInfo: nil, repeats: true)
        
        hidePeter()
    }
    @objc func hidePeter(){
        for peter in peterArray{
            peter.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(peterArray.count - 1)))
        peterArray[random].isHidden = false
    }
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            for peter in peterArray{
                peter.isHidden = true
                
                
                //highScore
                
                if self.score > self.highScore {
                    self.highScore = self.score
                    highScoreLabel.text = "HighScore \(self.highScore)"
                    UserDefaults.standard.set(self.highScore, forKey: "highscore")
                }
                
                
                //Alert
                
                let alert = UIAlertController(title: "Time's Up", message: "Do you wanna play again?", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
                let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                    //replay function
                    self.score = 0
                    self.scoreLabel.text = "Score: \(self.score)"
                    self.counter = 10
                    self.timeLabel.text = String(self.counter)
                    
                    self.timer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector (self.countDown), userInfo: nil, repeats: true)
                    self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hidePeter), userInfo: nil, repeats: true)
                    
                    
                    
                }
                
                alert.addAction(okButton)
                alert.addAction(replayButton)
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
    }
}
