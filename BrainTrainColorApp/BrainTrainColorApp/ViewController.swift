//
//  ViewController.swift
//  BrainTrainColorApp
//
//  Created by Joseph Cottingham on 11/28/20.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    
    var model = GameModel()
    var timer : Timer?

    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var meaingLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameoverScoreLabel: UILabel!
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var gameoverView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.restartGame()
        self.gameoverView.isUserInteractionEnabled = false
        gameoverView.isHidden = true
        self.meaingLabel.text = model.displayColorMeaing
        self.colorLabel.text = model.displayColorLabel
        self.colorLabel.textColor = model.displayColorHex
        self.scoreLabel.text = model.displayScoreLabel
        self.timeLabel.text = self.model.getTimeDisplay()
    }
    @IBAction func yesBtnPress(_ sender: Any){
        model.answerQuestion(answerYes: true)
        updateDisplay()
    }
    @IBAction func noBtnPress(_ sender: Any){
        model.answerQuestion(answerYes: false)
        updateDisplay()
    }
    @IBAction func restartBtnPress(_ sender: Any){
        restartGame()
    }
    
    func updateDisplay() {
        self.meaingLabel.text = model.displayColorMeaing
        self.colorLabel.text = model.displayColorLabel
        self.colorLabel.textColor = model.displayColorHex
        self.scoreLabel.text = model.displayScoreLabel
    }
    
    func restartGame() {
        self.gameoverView.isUserInteractionEnabled = false
        gameoverView.isHidden = true
        self.model.reset()
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFire), userInfo: nil, repeats: true)
        updateDisplay()
    }
    
    @objc func timerFire() {
        self.model.displayTimeInt -= 1
        self.timeLabel.text = self.model.getTimeDisplay()
        if self.model.displayTimeInt <= 0 {
            self.timer?.invalidate()
            gameover()
        }
    }
    func gameover(){
        yesBtn.isEnabled = false
        noBtn.isEnabled = false
        self.gameoverScoreLabel.text = "You scored \(model.displayScoreLabel) points"
        gameoverView.isUserInteractionEnabled = true
        gameoverView.isHidden = false
    }
}



