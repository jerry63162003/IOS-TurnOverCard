//
//  GameViewController.swift
//  MathsMaster
//
//  Created by roy on 2018/7/21.
//  Copyright © 2018年 roy. All rights reserved.
//

import UIKit
import LDProgressView

class GameViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    let gameConfig = GameConfig.shared
    var progressView = LDProgressView()
    let sound = SoundManager()
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairs())
    private lazy var score = game.score
    var cardView: CardButtonView!
    var timer: Timer?
    var time = 60 {
        didSet {
            timeLabel.text = "\(time)"
            progressView.progress = CGFloat(Float(time) / 60.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCardView()
        commonInit()
        if GameConfig.shared.isGameMusic {
            sound.playBackGroundSound()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addCardView (){
        cardView = CardButtonView(frame: CGRect.zero)
        view.addSubview(cardView)
        for i in cardView.cardButtons.indices {
            let button = cardView.cardButtons[i]
            button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        }
        cardView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.height.equalTo(CardViewHeight)
            make.width.equalTo(CardViewWidth)
        }
    }
    
    func numberOfPairs() -> Int {
        return (cardView.cardButtons.count + 1) / 2
    }
    
    @objc func buttonClick(_ sender: UIButton) {
        if let cardIndex = cardView.cardButtons.index(of: sender) {
            
            game.chooseCard(at: cardIndex)
            updateViewFromModel(from: sender)
            
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel(from sender: UIButton) {
        scoreLabel.text = "\(game.score)"
        
        for index in cardView.cardButtons.indices {
            let button = cardView.cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                
                button.setImage(UIImage.init(named: card.cardNames), for: .normal)
                if card.isMatched {
                    button.removeFromSuperview()
                }
                
            } else {
                
                if card.isMatched {
                    //                    print("Matched Card")
                    button.removeFromSuperview()
                } else {
                    button.setImage(#imageLiteral(resourceName: "组1"), for: .normal)
                }
            }
        }
        if cardView.subviews.count == 0 {
            allCardMatched()
        }
    }
    
    func allCardMatched() {
        
        cardView.removeFromSuperview()
        cardView.cardButtons.removeAll()
        addCardView()
        game = Concentration(numberOfPairsOfCards: numberOfPairs())
        game.score = Int(scoreLabel.text!)!
        self.time += 1
    }
    
    func commonInit() {
        progressView = LDProgressView()
        progressView.color = UIColor.yellow
        progressView.progress = 1.00
        progressView.animate = true
        progressView.showText = false
        progressView.type = LDProgressGradient
        progressView.background = UIColor.gray
        timeView.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(timeView)
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] (timer) in
            self?.time -= 1
            if self?.time == 0 {
                self?.timer?.invalidate()
                self?.gameOver()
            }
        }
    }
    
    func gameOver() {
        if score > GameConfig.shared.highScore {
            GameConfig.shared.highScore = score
        }
        if GameConfig.shared.isGameSound {
            sound.playOverSound()
        }
        sound.stopBackGroundSound()
        performSegue(withIdentifier: "toGameOver", sender: scoreLabel.text)
    }
    
    @IBAction func backClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameOver" {
            let vc = segue.destination as! GameOverViewController
            vc.score = score
        }
    }
    
}
