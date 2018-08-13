//
//  Card.swift
//  ConcentrationGame
//
//  Created by Paul Michael Reilly on 6/2/18.
//  Copyright © 2018 Pajato Technologies. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int

    static var identifierFactory = 0

    init(identifier: Int) {
        self.identifier = identifier
    }

    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
