//
//  Card.swift
//  Concentration
//
//  Created by iv on 3/31/19.
//  Copyright © 2019 ivsath. All rights reserved.
//

import Foundation

struct Card: Hashable {
    private var id: Int
    var isFaceUp = false
    var isMatched = false
    var hasBeenFlipped = false
    
    init() {
        id = Card.getUniqueId()
    }
    
    var hashValue: Int { return id }
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    private static var idFactory = 0
    private static func getUniqueId() -> Int {
        idFactory += 1
        return idFactory
    }
}
