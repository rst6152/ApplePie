//
//  ViewController.swift
//  APPLEPIE
//
//  Created by Ricky Titus on 11/19/19.
//  Copyright © 2019 Ricky Titus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["buccaneer", "swift", "glorious",
    "incandescent", "bug", "program"]
    var incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var xPoints = 0
    var currentGame: Game!

    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            xPoints = currentGame.points
            totalLosses += 1
            incorrectMovesAllowed = 7
            currentGame.incorrectMovesRemaining = 7
            treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        } else if currentGame.word == currentGame.formattedWord {
            xPoints = currentGame.points
            totalWins += 1
            view.backgroundColor = .green
            incorrectMovesAllowed = 7
            currentGame.incorrectMovesRemaining = 7
            treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        } else {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            view.backgroundColor = .white
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord,
                               incorrectMovesRemaining: incorrectMovesAllowed,
                               guessedLetters: [], points: xPoints)
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses), Points: \(currentGame.points)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        if incorrectMovesAllowed - currentGame.incorrectMovesRemaining == 1{
            view.backgroundColor = .red
            incorrectMovesAllowed -= 1
        } else{
            view.backgroundColor = .white
        }
    }


}

