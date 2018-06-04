//
//  ConcentrationModel.swift
//  ConcentrationGame
//
//  Created by Paul Michael Reilly on 6/2/18.
//  Copyright © 2018 Pajato Technologies. All rights reserved.
//

import Foundation

class ConcentrationModel {

    private(set) var cards = [Card]()

    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index),
               "ConcentrationModel.chooseCard(at: \(index)): invalid selected index!")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }

        }
        //cards[index].isFaceUp = !cards[index].isFaceUp
    }

    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0,
               "ConcentrationModel.init(numberOfPairsOfCards: \(numberOfPairsOfCards)): at least one pair of cards is required!")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards : Programming exercise 1
    }
}
