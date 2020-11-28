//
//  GameModel.swift
//  BrainTrainColorApp
//
//  Created by Joseph Cottingham on 11/28/20.
//

import Foundation
import UIKit


class GameModel: ObservableObject {
    
    @Published var displayColorMeaing = "RED"
    @Published var displayColorLabel = "RED"
    @Published var displayColorHex = UIColor.systemRed
    @Published var displayScoreLabel = ""
    var displayTimeInt = 60
    var displayScoreInt = 0
    var correctSelection = false
    
    init() {
    }
    
    enum colors: CaseIterable {
        case red
        case blue
        case green
        
        var colorHex: UIColor {
                switch self {
                    case .red:
                        return UIColor.systemRed
                    case .blue:
                        return UIColor.systemBlue
                    case .green:
                        return UIColor.systemGreen
                }
            }
        var colorString: String {
                switch self {
                    case .red:
                        return "red"
                    case .blue:
                        return "blue"
                    case .green:
                        return "green"
                }
            }
    }
    
    func changeColorDisplay() {
        let randomColor = colors.allCases.randomElement()
        self.displayColorMeaing = randomColor!.colorString
        self.displayColorLabel = colors.allCases.randomElement()!.colorString
        if (arc4random_uniform(2) == 0) {
            self.correctSelection = true
            self.displayColorHex = randomColor!.colorHex
        } else {
            self.correctSelection = false
            var newRandomColor = colors.allCases.randomElement()
            while newRandomColor == randomColor {
                newRandomColor = colors.allCases.randomElement()
            }
            self.displayColorHex = newRandomColor!.colorHex
        }
    }
    
    func reset() {
        self.displayScoreInt = 0
        self.displayTimeInt = 60
        self.updateScoreDisplay()
        self.changeColorDisplay()
    }
    
    func getTimeDisplay() -> String {
        let minutes = Int(self.displayTimeInt/60)
        let seconds = Int(self.displayTimeInt-(minutes*60))
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func updateScoreDisplay() {
        self.displayScoreLabel = String(self.displayScoreInt)
    }
    
    func answerQuestion(answerYes: Bool) -> Bool {
        var correct = false
        if (self.correctSelection == answerYes) {
            self.displayScoreInt += 10
            correct = true
        } else {
            self.displayScoreInt -= 10
        }
        self.updateScoreDisplay()
        self.changeColorDisplay()
        return correct
    }
}
