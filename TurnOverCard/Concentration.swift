//
//  Concentration.swift
//  Concentration
//
//  Created by Stanley Cheah on 8/11/18.
//  Copyright © 2018 Stanley Cheah. All rights reserved.
//

import Foundation

class Concentration {
	
	private(set) var cards = [Card]()
    var score = 0
    let gameConfig = GameConfig.shared
    var colorArr = [[String]]()
    private lazy var userChoice = colorArr.count.arc4random
    private lazy var theme = colorArr[userChoice]
    private var emoji = [Int : String]()
    
	private var indexOfOnlyFaceUp: Int? {
		get {
			var foundIndex: Int?
			
			// tests to see if there is only one face up card
			for index in cards.indices {
				if cards[index].isFaceUp {
					if foundIndex == nil {
						foundIndex = index
					}
					else { // there are 2 face up
						return nil
					}
				}
			}
			
			return foundIndex
		}
		
		set {
			for index in cards.indices {
				cards[index].isFaceUp = (index == newValue)
			}
		}
	}
	
	private func randomizeCards() {
		for index in cards.indices {
			let temp = cards[index]
			let randIndex = cards.count.arc4random
			cards[index] = cards[randIndex]
			cards[randIndex] = temp
		}
	}
	
    init(numberOfPairsOfCards: Int) {
        switch gameConfig.gameLevel {
        case .easy:
            colorArr = [["红", "绿", "紫", "黄", "蓝", "橙", "红", "绿", "紫", "黄", "蓝", "橙"]]
            break
        case .mid:
            colorArr = [["红", "粉", "绿", "紫", "黄", "蓝", "蓝绿", "橙", "红", "粉", "绿", "紫", "黄", "蓝", "蓝绿", "橙"]]
            break
        case .diff:
            colorArr = [["灰", "红", "粉", "绿", "紫", "黄", "黑", "蓝", "蓝绿", "橙", "灰", "红", "粉", "绿", "紫", "黄", "黑", "蓝", "蓝绿", "橙"]]
            break
        }
		for _ in 0..<numberOfPairsOfCards {
			let card = Card()
			cards += [card, card]
		}
		randomizeCards()
	}
	
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil {
            emoji[card.identifier] = theme.remove(at: theme.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
	func chooseCard(at index: Int) {
		assert(cards.indices.contains(index), "Concentration.chooseCard(\(index) is not in index range")
		
		if !cards[index].isMatched {
			
            cards[index].cardNames = emoji(for:cards[index])
            
			if let matchIndex = indexOfOnlyFaceUp, matchIndex != index {
                
				// either no cards or 2 cards face up
                if cards[matchIndex].cardNames == cards[index].cardNames{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                        score += 2
                }
				
				cards[index].isFaceUp = true
                
			} else {
                // only 1 card face up
				indexOfOnlyFaceUp = index
			}
        }
    }
}

extension Int {
	var arc4random: Int {
		if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
		}
		else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
		}
		else {
			return 0
		}
	}
}

