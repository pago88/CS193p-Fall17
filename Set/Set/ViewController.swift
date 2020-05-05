//
//  ViewController.swift
//  Set
//
//  Created by poltz on 4/23/20.
//  Copyright © 2020 Choo Choo Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = SetGame(numberOfCardsDealt: cardButtons.count)
    
    private var cardsInPlay = [Card]()
    
    @IBAction func touchCard(_ sender: UIButton) {
        
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func startNewGame(_ sender: UIButton) {
        cardsInPlay = game.cardsInPlay
        
        for index in cardsInPlay.indices {
            let card = cardsInPlay[index]
            cardButtons[index].setTitle("\(card.shape)" + "\(card.color)" + "\(card.number)" + "\(card.shading)", for: UIControl.State.normal)
        }
    }
}

