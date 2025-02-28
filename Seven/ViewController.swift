//
//  ViewController.swift
//  Seven
//
//  Created by HPro2 on 2/10/25.
//

import UIKit

enum Saved {
    static let level = "com.jonesclass.hu.seven.level"
    static let score = "com.jonesclass.hu.seven.score"
}

class ViewController: UIViewController {
    
    var saveGame = UserDefaults.standard
    var confettiSpawner: Confetti!
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var answers = [String]()
    var totalLevels = 1
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var level: Int = 1 {
        didSet {
            levelLabel.text = "Level: \(level)"
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    
    @IBAction func submitPressed(_ sender: UIButton) {
        if let answerIndex = answers.firstIndex(of: guessTextField.text!) {
            guessTextField.text = ""
            activatedButtons.removeAll()
            var answerArray = answersLabel.text?.components(separatedBy: "\n")
            answerArray![answerIndex] = answers[answerIndex]
            answersLabel.text = answerArray?.joined(separator: "\n")
            score += 1
            checkForWinner()
            
        } else {
            //wrong
        }
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        guessTextField.text = ""
        for button in activatedButtons {
            button.isEnabled = true
        }
        activatedButtons.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findSubviews(view: view)
        countLevels()
        if let currentLevel = saveGame.string(forKey: Saved.level) {
            level = Int(currentLevel)!
            score = saveGame.integer(forKey: Saved.score)
        }
        confettiSpawner = Confetti(frame: self.view.bounds)
        loadLevel()
    }
    
    func loadLevel() {
        var clueString = ""
        var answerString = ""
        var letterBits = [String]()
        
        if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
            if let levelContents = try? String(contentsOfFile: levelFilePath, encoding: .utf8) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    //print(line)
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue) \n"
                    
                    let answerWord = answer.replacingOccurrences(of: "|", with: "")
                    answers.append(answerWord)
                    answerString += "\(answerWord.count) letters \n"
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            } else {
                //no contents
            }
        } else {
            //no file
        }
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = answerString.trimmingCharacters(in: .whitespacesAndNewlines)
        letterBits.shuffle()
        print(letterButtons.count)
        if letterBits.count == letterButtons.count {
            for index in 0..<letterButtons.count {
                letterButtons[index].setTitle(letterBits[index], for: .normal)
            }
        }
    }
    
    @objc func letterTapped(button: UIButton) {
        guessTextField.text = guessTextField.text! + button.titleLabel!.text!
        activatedButtons.append(button)
        button.isEnabled = false
    }
    
    func findSubviews(view: UIView) {
        if view.tag == 42 {
            let button = view as! UIButton
            button.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
            letterButtons.append(button)
        } else {
            for subview in view.subviews {
                findSubviews(view: subview)
            }
        }
    }
    
    func checkForWinner() {
        if score % 7 == 0 {
            self.view.addSubview(confettiSpawner)
            confettiSpawner.startConfetti() 
            var title = "Next Level"
            var message = "You have passed the level!"
            if level >= totalLevels {
                title = "Play Again"
                message = "You have won the game!"
            }
            let ac = UIAlertController(title: "Congratulations!", message: message, preferredStyle: .alert)
            let newGameAction = UIAlertAction(title: title, style: .default) {
                _ in self.levelUp()
            }
            ac.addAction(newGameAction)
            present(ac, animated: true)
        }
    }

    func countLevels() {
        var counter = 1
        while Bundle.main.path(forResource: "level\(counter)", ofType: "txt") != nil {
            counter += 1
        }
        totalLevels = counter - 1
        print("Total Levels: \(totalLevels)")
    }
    
    func levelUp() {
        confettiSpawner.stopConfetti()
        confettiSpawner.removeFromSuperview()
        if level >= totalLevels {
            level = 0
            score = 0
        }
        level += 1
        saveGame.set(level, forKey: Saved.level)
        saveGame.set(score, forKey: Saved.score)
        answers.removeAll()
        for button in letterButtons {
            button.isEnabled = true
        }
        loadLevel()
    }
}

