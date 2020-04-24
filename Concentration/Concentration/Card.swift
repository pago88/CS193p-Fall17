//
//  Card.swift
//  Concentration
//
//  Created by poltz on 3/28/20.
//  Copyright © 2020 Choo Choo Inc. All rights reserved.
//

import Foundation

struct Card : Hashable
{
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    var isPreviouslySeen = false
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

