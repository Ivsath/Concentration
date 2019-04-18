//
//  Concentration.swift
//  Concentration
//
//  Created by iv on 3/31/19.
//  Copyright © 2019 ivsath. All rights reserved.
//

import Foundation

class Concentration {
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
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Consentration.init(\(numberOfPairsOfCards): you must have at least one pair of cards")
        for _ in 1 ... numberOfPairsOfCards {
            let card = Card()
            cards.append(contentsOf: [card, card])
        }
        cards = cards.shuffled()
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Consentration.chooseCard(at: \(index): chosen index not  in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    subtractScore(index: index, matchIndex: matchIndex)
                    cards[matchIndex].hasBeenFlipped = true
                    cards[index].hasBeenFlipped = true
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or two cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    private func subtractScore(index: Int, matchIndex: Int) {
        if cards[index].hasBeenFlipped == true && cards[matchIndex].hasBeenFlipped == true {
            score -= 2
        } else if cards[index].hasBeenFlipped == true || cards[matchIndex].hasBeenFlipped == true {
            score -= 1
        }
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
