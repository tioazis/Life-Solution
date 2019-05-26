//
//  ViewController.swift
//  Life Solution
//
//  Created by Azis Jabbar Susetio on 20/05/19.
//  Copyright © 2019 Azis Susetio. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    private var state = 0
    private var maxScore = 0 //score maksimal
    private var score = 0 //score existinv
    
    private let spiritText : [String] = ["Good...","Nice!", "Aw..", "Yeah...", "Go Ahead..."]
    private let almostText = ["Almost...", "Almost done..."]
    private let finishText = ["Congratulation", "Key of All Solution", "in our lives", "is", "patience"]
    private let howText = ["Just...", "Be Patience"]
    
    
    private var clicked = 0

    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var blackBG: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //fontSizeAnimation(label: textLabel)
        tutorial()
        
        

    }

    @IBAction func actionBtn(_ sender: Any) {
        print("actionBTN Clicked")
        state = 1
        clicked += 1
        action()
        
        
    }
    
    @IBAction func blackBG(_ sender: Any) {
        print("blackBG Clicked")
        hint()
    }
    
    
}

//####################################################
// MARK: Gameloop

extension ViewController {
    
    func newGames(){
        self.state = 0
        self.maxScore  = Int.random(in: 9...15)
        self.score = 0
    }
    
    func gameLoop(){
        //init timer
        //newgame
        //tutorial
        //startGame
        //finish
        //result
        //newgame
    }
    //MARK : ngasih hint ketika di klik sembarang
    private func hint(){
        if state != 1{
            
            UIView.animate(withDuration: 0.1, animations: {
                self.actionBtn.layer.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                self.actionBtn.layer.opacity = 0.3
                self.actionBtn.layer.cornerRadius = 1
                
            }, completion: { finished in
                UIView.animate(withDuration: 0.5, animations: {
                    self.actionBtn.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    self.actionBtn.layer.opacity = 1
                    self.actionBtn.layer.cornerRadius = 1
                })
            })
        }
    }
    
    //MARK : aksi ketika dipencet tombol
    private func action(){
        let textFrame = CGRect(x: 0, y: (self.view.bounds.height - 100)/2, width: self.view.frame.width, height: 50)
        let time = TimeInterval(Float.random(in: 0.1...5))
        
        if state == 1 {
            self.actionBtn.layer.cornerRadius = 1
            UIView.animate(withDuration: time, animations: {
                self.actionBtn.layer.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                self.actionBtn.frame = CGRect(x: 0, y: 0, width: 414, height: 898)
                self.actionBtn.layer.cornerRadius = self.actionBtn.frame.width/7
                
            }, completion: { finished in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                    //animation spacing could be a negative value of half the animation to appear to fade between strings
                    
                }
                
                UIView.animate(withDuration: TimeInterval(Float.random(in: 0.1...0.2)), animations: {
                    self.animateText(subtitles: [self.spiritText[Int.random(in: 0...self.spiritText.count-1)]], duration: 1, animationSpacing: 0, frame: textFrame, targetLayer: self.view.layer)
                }, completion: {
                    finished in
                    UIView.animateKeyframes(withDuration: TimeInterval(Float.random(in: 0.1...0.2)), delay: 1.5, animations: {
                        self.actionBtn.frame = CGRect(x: 157, y: 567, width: 121, height: 121)
                        self.actionBtn.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        self.actionBtn.layer.cornerRadius = 1
                        self.state = 0
                    })
                })
                
            })
        }
    }
    
    private func tutorial(){
        let textFrame = CGRect(x: 0, y: (self.view.bounds.height - 100)/2, width: self.view.frame.width, height: 50)
        
        
        
        UIView.animate(withDuration: 2, delay: 5, animations: {
            self.blackBG.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            //animation spacing could be a negative value of half the animation to appear to fade between strings
            self.animateText(subtitles: self.howText, duration: 3, animationSpacing: 0, frame: textFrame, targetLayer: self.view.layer)
        }
        
    }
}

//####################################################
// MARK: Animation
extension ViewController {
    private func fontSizeAnimation(label: UILabel) {
        let textLayer = CATextLayer()
        //textLayer.backgroundColor = UIColor.gray.cgColor
        
        textLayer.frame = label.layer.frame
        textLayer.string = "Just Be Patient"
        textLayer.position = label.layer.position
        textLayer.font = label.font
        textLayer.alignmentMode = CATextLayerAlignmentMode(rawValue: "center")
        
        view.layer.addSublayer(textLayer)
        
        // Animate font size
        let animation = CABasicAnimation(keyPath: "fontSize")
        animation.toValue = CGFloat(30)
        animation.duration = 5.0
        textLayer.add(animation, forKey: "label")
        
        //Animate Font color
        let animation1 = CABasicAnimation(keyPath: "foregroundColor")
        animation1.toValue = UIColor.black.cgColor
        animation1.duration = 2.0
        textLayer.add(animation1, forKey: "label")
    }
    
    func animateText(subtitles:[String],
                     duration:Double,animationSpacing:Double,
                     frame:CGRect,targetLayer:CALayer){
        var currentTime : Double = 0
        for x in 0..<subtitles.count{
            let string = subtitles[x]
            let textLayer = CATextLayer()
            textLayer.frame = frame
            textLayer.string = string
            textLayer.font = UIFont.systemFont(ofSize: 20)
            textLayer.foregroundColor = UIColor.black.cgColor
            textLayer.fontSize = 50
            textLayer.alignmentMode = CATextLayerAlignmentMode.center
            
            let anim = getSubtitlesAnimation(duration: duration, startTime: currentTime)
            targetLayer.addSublayer(textLayer)
            textLayer.add(anim, forKey: "opacityLayer\(x)")
            currentTime += duration + animationSpacing
        }
    }
    
    func getSubtitlesAnimation(duration: CFTimeInterval,startTime:Double)->CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath:"opacity")
        animation.duration = duration
        //have to fade in and out with a single animation because AVFoundation
        //won't allow you to animate the same propery on the same layer with
        //two different animations
        animation.values = [0,0.5,1,0.5,0]
        animation.keyTimes = [0,0.25,0.5,0.75,1]
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.both
        //Replace with AVCoreAnimationBeginTimeAtZero for AVFoundation
        animation.beginTime = CACurrentMediaTime() + startTime
        return animation
    }
    
    func getTutorialAnimation(duration:CFTimeInterval,startTime:Double)->CAKeyframeAnimation{
        let animation = CAKeyframeAnimation(keyPath: "tutorial")
        
        
        return animation
    }
    
}
