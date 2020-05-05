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
    
    private(set) var cardsInPlay = [Card]()
    
    private var topOfDeck = 0
    
    var selectedCards = [Card]()
    
 //   private var matchedCards = [Card]()
    
    var matchingSet: [Card]? {
        mutating get {
            return isMatch() ? selectedCards : nil
        }
    }
    
    private var topOfDeckCard: Card? {
        mutating get {
            if topOfDeck < deck.count {
                let cardToDeal = deck[topOfDeck]
                topOfDeck += 1
                return cardToDeal
            } else {
                return nil
            }
        }
    }
    
    mutating func chooseCard(at index: Int)
    {
        assert(cardsInPlay.indices.contains(index), "SetGame.chooseCard(at: \(index)): chosen index not in the cards in play")
        
        switch selectedCards.count {
        case 0:
            selectedCards.append(cardsInPlay[index])
        case 1, 2:
            if let existingCardIndex = selectedCards.firstIndex(of: cardsInPlay[index]) {
                selectedCards.remove(at: existingCardIndex)
            } else {
                selectedCards.append(cardsInPlay[index])
            }
        case 3:
            dealThreeCards()
            
        default:
            break
        }
    }
    
    mutating func dealThreeCards()
    {
        if isMatch() {
 //           matchedCards.append(contentsOf: selectedCards)
            for selectedCard in selectedCards {
                if let indexOfSelectedCard = cardsInPlay.firstIndex(of: selectedCard) {
                    if let nextCard = topOfDeckCard {
                        cardsInPlay[indexOfSelectedCard] = nextCard
                    } else {
                        cardsInPlay.remove(at: indexOfSelectedCard)
                    }
                }
                selectedCards = [Card]()
            }
        } else {
            for _ in 0..<3 {
                if let nextCard = topOfDeckCard {
                    cardsInPlay.append(nextCard)
                }
            }
        }
    }
    
    mutating private func isMatch() -> Bool
    {
        var validMatch = false
        
        if selectedCards.count == 3 {
            let card1 = selectedCards[0], card2 = selectedCards[1], card3 = selectedCards[2]
            
            if card1.color.tripleEquals(value2: card2.color, value3: card3.color) || card1.color.tripleNotEquals(value2: card2.color, value3: card3.color),
                card1.shape.tripleEquals(value2: card2.shape, value3: card3.shape) || card1.shape.tripleNotEquals(value2: card2.shape, value3: card3.shape),
                card1.number.tripleEquals(value2: card2.number, value3: card3.number) || card1.number.tripleNotEquals(value2: card2.number, value3: card3.number),
                card1.shading.tripleEquals(value2: card2.shading, value3: card3.shading) || card1.shading.tripleNotEquals(value2: card2.shading, value3: card3.shading) {
                    validMatch = true
            }
        }
        
        return validMatch
        
    }
    
    // MARK: initialization
    init(numberOfCardsDealt: Int)
    {
        assert(numberOfCardsDealt > 0, "SetGame.init(numberOfCardsDealt: \(numberOfCardsDealt)): can't start with negative number of cards")
        assert(numberOfCardsDealt <= 81, "SetGame.init(numberOfCardsDealt: \(numberOfCardsDealt)): can't start with more cards than the deck contains")
        
        // each card has 4 features, and each feature has 4 unique options. Total of 81 cards, each unique
        for shape in 1...4 {
            for number in 1...4 {
                for shading in 1...4 {
                    for color in 1...4 {
                        deck.append(Card(shape: shape, number: number, shading: shading, color: color))
                    }
                }
            }
        }
        
        deck.shuffle()
        
        cardsInPlay.append(contentsOf: deck[0..<numberOfCardsDealt])
        topOfDeck = numberOfCardsDealt
    }
}

extension Int {
    func tripleEquals(value2: Int, value3: Int) -> Bool {
        if self == value2 && self == value3 && value2 == value3 {
            return true
        } else {
            return false
        }
    }
    
    func tripleNotEquals(value2: Int, value3: Int) -> Bool {
        if self != value2 && self != value3 && value2 != value3 {
            return true
        } else {
            return false
        }
    }
}
