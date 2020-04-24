//
//  Concentration.swift
//  Concentration
//
//  Created by poltz on 3/28/20.
//  Copyright © 2020 Choo Choo Inc. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var flipCount = 0
    var score = 0
    
    private var lastCardChosenAt: Date?
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard {
                if matchIndex != index {
                    
                    // check if cards match
                    if cards[matchIndex] == cards[index] {
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                        score += determineScore(from: 2)
                    } else {
                        var penaltyForMismatchingSeenCards = 0
                        penaltyForMismatchingSeenCards = cards[matchIndex].isPreviouslySeen ? penaltyForMismatchingSeenCards - 1 : penaltyForMismatchingSeenCards
                        penaltyForMismatchingSeenCards = cards[index].isPreviouslySeen ? penaltyForMismatchingSeenCards - 1 : penaltyForMismatchingSeenCards
                        score += determineScore(from: penaltyForMismatchingSeenCards)
                    }
                    cards[index].isFaceUp = true
                    flipCount += 1
                    cards[index].isPreviouslySeen = true
                    cards[matchIndex].isPreviouslySeen = true
                }
                
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
                flipCount += 1
                lastCardChosenAt = Date()
            }
        }
    }

    private mutating func determineScore(from baseValue: Int) -> Int {
        var multiplier = 0
        let currentCardChosenAt = Date()
        if let previousCardTime = lastCardChosenAt {
            let timeDifferenceBetweenTwoCards = currentCardChosenAt.timeIntervalSince(previousCardTime)
            switch timeDifferenceBetweenTwoCards {
            case 0..<2 where baseValue > 0:
                multiplier = 4
            case 2..<5 where baseValue > 0:
                multiplier = 3
            case 5..<10 where baseValue > 0:
                multiplier = 2
            case 10... where baseValue > 0:
                multiplier = 1
            case 0..<2 where baseValue < 0:
                multiplier = 1
            case 2..<5 where baseValue < 0:
                multiplier = 2
            case 5..<10 where baseValue < 0:
                multiplier = 3
            case 10... where baseValue < 0:
                multiplier = 4
            default:
                break
            }
        }
        lastCardChosenAt = currentCardChosenAt
        return multiplier * baseValue
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least on pair of cards")
        for _  in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
        
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

