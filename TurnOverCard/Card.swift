//
//  Card.swift
//  Concentration
//
//  Created by Stanley Cheah on 8/11/18.
//  Copyright © 2018 Stanley Cheah. All rights reserved.
//

import Foundation

struct Card {
	
	private static var uniqueIdentifier = 0
	
	var identifier: Int
    var cardNames: String
	var isFaceUp = false
	var isMatched = false
	
	private static func getUniqueIdentifier() -> Int {
		Card.uniqueIdentifier += 1
		return Card.uniqueIdentifier
	}
	
	init() {
		identifier = Card.getUniqueIdentifier()
        cardNames = ""
	}
}
