//
//  ViewController.swift
//  Concentration
//
//  Created by poltz on 4/7/20.
//  Copyright © 2020 Choo Choo Inc. All rights reserved.
//

import UIKit

struct Theme {
    var emojiList = [String]()
    var backgroundViewColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var backCardColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        game = startNewGame()
    }
    
    private lazy var game = startNewGame()
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1) / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction private func newGame(_ sender: UIButton) {
        game = startNewGame()
        updateViewFromModel()
        //   flipCount = 0
    }
    
    private var emojiChoices = [String]()
    
    private var themeOfThisGame = Theme()
    
    private var emoji = [Card: String]()
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    private(set) var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    

    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : themeOfThisGame.backCardColor
            }
            flipCount = game.flipCount
            score = game.score
        }
    }
    
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
    
    
    private let gameThemes = [
        "halloween": Theme(emojiList: ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"], backgroundViewColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), backCardColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)),
        "animal": Theme(emojiList: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨"], backgroundViewColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), backCardColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)),
        "sport": Theme(emojiList: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🏐", "🥏", "🏉", "🎱"], backgroundViewColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), backCardColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),
        "faces": Theme(emojiList: ["😀", "😅", "🙂", "😘", "😗", "😛", "🤨", "🤩", "😕"], backgroundViewColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), backCardColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),
        "flags": Theme(emojiList: ["🏁", "🇦🇷", "🇧🇲", "🇻🇬", "🇮🇴", "🇨🇻", "🇪🇪", "🇪🇨", "🇬🇫"], backgroundViewColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), backCardColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)),
        "food": Theme(emojiList: ["🍏", "🍌", "🍑", "🌶", "🥒", "🥨", "🥩", "🥚", "🥪"], backgroundViewColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), backCardColor: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))
    ]
    
    private func startNewGame() -> Concentration {
        let nameOfAllThemes = Array(gameThemes.keys)
        let nameOfThisGamesTheme = nameOfAllThemes[nameOfAllThemes.count.arc4random]
        
        themeOfThisGame = gameThemes[nameOfThisGamesTheme] ?? Theme()
        emojiChoices = themeOfThisGame.emojiList
        
        self.view.backgroundColor = themeOfThisGame.backgroundViewColor
        for card in cardButtons {
            card.backgroundColor = themeOfThisGame.backCardColor
        }
        
        return Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        
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

