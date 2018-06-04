//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Paul Michael Reilly on 6/2/18.
//  Copyright © 2018 Pajato Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = ConcentrationModel(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Invalid button: not connected!")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            processCard(withCard: game.cards[index], withButton: cardButtons[index])
        }
    }
    
    private func processCard(withCard card: Card, withButton button: UIButton) {
        button.setTitle(card.isFaceUp ? emoji(for: card) : "", for: UIControlState.normal)
        button.backgroundColor = card.isFaceUp ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    }
    
    private var emojiChoices = ["🎃", "👻", "👿", "☠️", "👽", "🕷", "🍎", "🍐", "🦃"]
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
