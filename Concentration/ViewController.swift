//
//  ViewController.swift
//  Concentration
//
//  Created by iv on 3/29/19.
//  Copyright © 2019 ivsath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private weak var gameScoreLabel: UILabel!
    
    @IBAction private func newGame() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = getRandomEmojiTheme()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        game.flipCount += 1
        let cardNumber = cardButtons.firstIndex(of: sender)!
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        //flipCountLabel.text = "Flips: \(game.flipCount)"
        updateFlipCountLabel()
        gameScoreLabel.text = "Score: \(game.score)"
        for index in cardButtons.indices {
            let card = game.cards[index]
            let button = cardButtons[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
                button.isUserInteractionEnabled = card.isMatched ? false : true
            }
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .backgroundColor: #colorLiteral(red: 0, green: 0.4127188747, blue: 0.7297152602, alpha: 0.95)
        ]
        let atrributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = atrributedString
    }
    
    private lazy var emojiChoices = getRandomEmojiTheme()
    private var emojiCollection = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emojiCollection[card] == nil, emojiChoices.count > 0 {
            emojiCollection[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emojiCollection[card] ?? "?"
    }
    
    private func getRandomEmojiTheme() -> [String] {
        let emojiThemes = [
            ["🏈", "⚽️", "🏀", "⛸", "🏓", "🏒", "🎱", "🎳", "⛳️", "⚾️", "🎿", "🥊"],
            ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮"],
            ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍒", "🍑", "🥥"]
        ]
        return emojiThemes[emojiThemes.count.arc4random]
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
