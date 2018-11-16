//
//  ViewController.swift
//  TurnOverCard
//
//  Created by user04 on 2018/8/25.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var modeButton: UIButton!
    @IBOutlet weak var highScore: UILabel!
    let gameConfig = GameConfig.shared
    let scoreValue = GameConfig.shared.highScore
    var modeButtonList: [UIButton] = []
    
    lazy var modeView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        
        let alphaView = UIView()
        alphaView.backgroundColor = UIColor.black
        alphaView.alpha = 0.8
        bgView.addSubview(alphaView)
        alphaView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(bgView)
        }
        
        let bgImage = UIImageView(image: #imageLiteral(resourceName: "难度选择弹窗"))
        bgImage.isUserInteractionEnabled = true
        bgView.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.center.equalTo(bgView)
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(#imageLiteral(resourceName: "叉"), for: .normal)
        cancelButton.tag = 31
        cancelButton.addTarget(self, action: #selector(modeSelectClick(_:)), for: .touchUpInside)
        bgView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints({ (make) in
            make.top.equalTo(bgImage).offset(6)
            make.centerX.equalTo(bgImage.snp.right)
        })
        
        let button1 = UIButton()
        button1.addTarget(self, action: #selector(modeSelectClick(_:)), for: .touchUpInside)
        button1.tag = 10
        button1.setImage(#imageLiteral(resourceName: "简单"), for: .normal)
        bgImage.addSubview(button1)
        button1.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImage)
            make.top.equalTo(bgImage).offset(245)
        }
        
        let button2 = UIButton()
        button2.addTarget(self, action: #selector(modeSelectClick(_:)), for: .touchUpInside)
        button2.tag = 11
        button2.setImage(#imageLiteral(resourceName: "中等"), for: .normal)
        bgImage.addSubview(button2)
        button2.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImage)
            make.top.equalTo(button1.snp.bottom).offset(15)
        }
        
        let button3 = UIButton()
        button3.addTarget(self, action: #selector(modeSelectClick(_:)), for: .touchUpInside)
        button3.tag = 12
        button3.setImage(#imageLiteral(resourceName: "困难"), for: .normal)
        bgImage.addSubview(button3)
        button3.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImage)
            make.top.equalTo(button2.snp.bottom).offset(15)
        }
        
        modeButtonList = [button1, button2, button3]
        
        switch gameConfig.gameLevel {
        case .easy:
            button1.setImage(#imageLiteral(resourceName: "點擊简单"), for: .normal)
            break
        case .mid:
            button2.setImage(#imageLiteral(resourceName: "點擊中等"), for: .normal)
            break
        case .diff:
            button3.setImage(#imageLiteral(resourceName: "點擊困难"), for: .normal)
            break
        }
        
        return bgView
    }()
    
    lazy var settingView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        
        let alphaView = UIView()
        alphaView.backgroundColor = UIColor.black
        alphaView.alpha = 0.8
        bgView.addSubview(alphaView)
        alphaView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(bgView)
        }
        
        let bgImage = UIImageView(image:#imageLiteral(resourceName: "设置弹窗"))
        bgImage.isUserInteractionEnabled = true
        bgView.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.center.equalTo(bgView)
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(#imageLiteral(resourceName: "叉"), for: .normal)
        cancelButton.tag = 31
        cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        bgView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints({ (make) in
            make.top.equalTo(bgImage).offset(6)
            make.centerX.equalTo(bgImage.snp.right)
        })
        
        let label1 = UILabel()
        label1.textColor = UIColor.black
        label1.text = "音乐"
        label1.font = UIFont.systemFont(ofSize: 21)
        bgImage.addSubview(label1)
        label1.snp.makeConstraints({ (make) in
            make.left.equalTo(bgImage).offset(75)
            make.top.equalTo(bgImage).offset(252)
        })
        
        let label2 = UILabel()
        label2.textColor = UIColor.black
        label2.text = "音效"
        label2.font = UIFont.systemFont(ofSize: 21)
        bgImage.addSubview(label2)
        label2.snp.makeConstraints({ (make) in
            make.left.equalTo(label1)
            make.top.equalTo(label1.snp.bottom).offset(38)
        })
        
        let musicButton = UIButton()
        musicButton.isSelected = gameConfig.isGameMusic
        musicButton.setImage(#imageLiteral(resourceName: "on"), for: .selected)
        musicButton.setImage(#imageLiteral(resourceName: "off"), for: .normal)
        musicButton.tag = 10
        musicButton.addTarget(self, action: #selector(settingClick(_:)), for: .touchUpInside)
        bgImage.addSubview(musicButton)
        musicButton.snp.makeConstraints({ (make) in
            make.left.equalTo(label1.snp.right).offset(14)
            make.centerY.equalTo(label1)
        })
        
        let soundButton = UIButton()
        soundButton.isSelected = gameConfig.isGameSound
        soundButton.setImage(#imageLiteral(resourceName: "on"), for: .selected)
        soundButton.setImage(#imageLiteral(resourceName: "off"), for: .normal)
        soundButton.tag = 11
        soundButton.addTarget(self, action: #selector(settingClick(_:)), for: .touchUpInside)
        bgImage.addSubview(soundButton)
        soundButton.snp.makeConstraints({ (make) in
            make.left.equalTo(label2.snp.right).offset(14)
            make.centerY.equalTo(label2)
        })
        
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        button.tag = 30
        button.setImage(#imageLiteral(resourceName: "关于我们"), for: .normal)
        bgImage.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImage)
            make.top.equalTo(label2.snp.bottom).offset(40)
        }
        
        return bgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highScore.text = "最高分:\(scoreValue)"
        commonInit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func commonInit() {
        let level = gameConfig.gameLevel.rawValue
        
        modeButton.setImage(UIImage(named: "难度\(level)按钮"), for: .normal)
    }
    
    func openWebView() {
        let webview = WebViewController()
        webview.urlStr = "http://static.tgnbj.com/turnHappy/index.html"
        var top = UIApplication.shared.keyWindow?.rootViewController
        while ((top?.presentedViewController) != nil) {
            top = top?.presentedViewController
        }
        top?.present(webview, animated: true, completion: nil)
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {

        if sender.tag == 11 {
            openMode()
        }
        
        if sender.tag == 12 {
            openSetting()
        }
        
        if sender.tag == 30 {
            openWebView()
        }
        
        if sender.tag == 31 || sender.tag == 30{
            settingView.removeFromSuperview()
        }
    }
    
    @objc func settingClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.tag == 10 {
            gameConfig.isGameMusic = sender.isSelected
        }
        if sender.tag == 11 {
            gameConfig.isGameSound = sender.isSelected
        }
    }
    
    @objc func modeSelectClick(_ sender: UIButton) {
        
        if sender.tag == 31 {
            modeView.removeFromSuperview()
            return
        }
        
        let button1 = modeButtonList[0]
        let button2 = modeButtonList[1]
        let button3 = modeButtonList[2]
        
        var image = UIImage()
        switch sender.tag {
        case 10:
            gameConfig.gameLevel = .easy
            sender.setImage(#imageLiteral(resourceName: "點擊简单"), for: .normal)
            button2.setImage(#imageLiteral(resourceName: "中等"), for: .normal)
            button3.setImage(#imageLiteral(resourceName: "困难"), for: .normal)
            image = #imageLiteral(resourceName: "难度easy按钮")
            break
        case 11:
            gameConfig.gameLevel = .mid
            sender.setImage(#imageLiteral(resourceName: "點擊中等"), for: .normal)
            button1.setImage(#imageLiteral(resourceName: "简单"), for: .normal)
            button3.setImage(#imageLiteral(resourceName: "困难"), for: .normal)
            image = #imageLiteral(resourceName: "难度mid按钮")
            break
        case 12:
            gameConfig.gameLevel = .diff
            sender.setImage(#imageLiteral(resourceName: "點擊困难"), for: .normal)
            button1.setImage(#imageLiteral(resourceName: "简单"), for: .normal)
            button2.setImage(#imageLiteral(resourceName: "中等"), for: .normal)
            image = #imageLiteral(resourceName: "难度diff按钮")
            break
        default:
            break
        }
        
        modeButton.setImage(image, for: .normal)
        
        modeView.removeFromSuperview()
    }
    
    func openMode() {
        view.addSubview(modeView)
        modeView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(view)
        }
    }
    
    func openSetting() {
        view.addSubview(settingView)
        settingView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(view)
        }
    }


}

