//
//  CardButtonView.swift
//  TurnOverCard
//
//  Created by user04 on 2018/8/30.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit

class CardButtonView: UIView {
    
    let gameConfig = GameConfig.shared
    //橫
    var horizontalCard: Int!
    //縱
    var verticalCard: Int!
    
    let mainView = UIScreen.main.bounds.size
    
    var cardButtons = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        switch gameConfig.gameLevel {
        case .easy:
            horizontalCard = 4
            verticalCard = 6
            break
        case .mid:
            horizontalCard = 4
            verticalCard = 8
            break
        case .diff:
            horizontalCard = 5
            verticalCard = 8
            break
        }
        let cardHeight = (CardViewHeight - CGFloat((verticalCard + 1) * 10)) / CGFloat(verticalCard)
        let cardWidth = (CardViewWidth -  CGFloat((horizontalCard + 1) * 10)) / CGFloat(horizontalCard)
        
        for j in 0..<verticalCard {
            for i in 0..<horizontalCard {
                let cardButton = UIButton()
                cardButton.setImage(#imageLiteral(resourceName: "组1"), for: .normal)
                self.addSubview(cardButton)
                cardButton.snp.makeConstraints({ (make) in
                    make.left.equalTo(self).offset(10 + (cardWidth + 10) * CGFloat(i))
                    make.width.equalTo(cardWidth)
                    make.height.equalTo(cardHeight)
                    make.top.equalTo(self).offset(10 + (cardHeight + 10) * CGFloat(j))
                })
                cardButtons.append(cardButton)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
