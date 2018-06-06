//
//  ConcentrationModel.swift
//  ConcentrationGame
//
//  Created by Paul Michael Reilly on 6/2/18.
//  Copyright © 2018 Pajato Technologies. All rights reserved.
//

import Foundation

struct ConcentrationModel {

    private(set) var cards = [Card]()

    private var indexOfOneAndOnlyFaceUpCard: Int? {
        // Return nil if no cards are face up or if more than one
        // cards is face tup, otherwise return the index of the one
        // face up card.
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }

        // Set each card to face down, except for the one being set now.
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index),
               "ConcentrationModel.chooseCard(at: \(index)): invalid selected index!")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                indexOfOneAndOnlyFaceUpCard = nil
                cards[index].isFaceUp = true
                cards[matchIndex].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
