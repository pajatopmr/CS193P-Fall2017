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
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
 
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }

    @IBOutlet private var cardButtons: [UIButton]!

    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            print("Card touched has number \(cardNumber)")
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

    //private var emojiChoices = ["🎃", "👻", "👿", "☠️", "👽", "🕷", "🍎", "🍐", "🦃"]
    private var emojiChoices = "🎃👻👿☠️👽🕷🍎🍐🦃"

    private var emoji = [Card:String]()

    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        // Generate a random value between 0 and the int value (half open) of the correct sign.  For 0, return 0.
        switch self {
        case 0 : return 0;
        default: return self > 0 ? Int(arc4random_uniform(UInt32(self))) : -Int(arc4random_uniform(UInt32(abs(self))))
        }
    }
}
