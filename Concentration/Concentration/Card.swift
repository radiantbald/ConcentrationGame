//
//  Card.swift
//  Concentration
//
//  Created by Олег Попов on 15.02.2022.
//

import Foundation

struct Card{
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierNumber = 0
    
    private static func identifierGenerator() -> Int {
        identifierNumber += 1
        return identifierNumber
    }
    
    init() {
        self.identifier = Card.identifierGenerator()
    }
}
