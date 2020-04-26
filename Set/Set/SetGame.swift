//
//  SetGame.swift
//  Set
//
//  Created by poltz on 4/24/20.
//  Copyright © 2020 Choo Choo Inc. All rights reserved.
//

import Foundation

struct SetGame {
    private var deck = [Card]()
    
    
    
    // MARK: initialization
    init()
    {
        var currentCardIndex = 0
        for shape in 1...4 {
            for number in 1...4 {
                for shading in 1...4 {
                    for color in 1...4 {
                        deck[currentCardIndex] = Card(shape: shape, number: number, shading: shading, color: color)
                        currentCardIndex += 1
                    }
                }
            }
        }
        
        deck.shuffle()
    }
}
