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
    private var wrong = 0
    
    private let spiritText = ["Good...","Nice!", "Aw..", "Yeah...", "Go Ahead..."]
    private let almostText = ["almost complete!", "Almost done!", "You can do it!"]
    private let finishText = ["Congratulation", "Key of All Solution", "in our lives", "is", "patience"]
    private let howText = ["Just...", "Be Patience"]
    
    
    private var clicked = 0

    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var blackBG: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.maxScore = Int.random(in: 9...15)
        print("max score \(self.maxScore)")
        // Do any additional setup after loading the view.
        //fontSizeAnimation(label: textLabel)
        tutorial()
    }

    @IBAction func actionBtn(_ sender: Any) {
        print("state \(state) score \(score)")
        state = 1
        
        
        if state == 1 && score < maxScore{
            if score >= (maxScore-3){
                action(textArray: almostText)
            } else if maxScore != 3{
                action(textArray: spiritText)
            }
        }
        
        
    }
    
    @IBAction func blackBG(_ sender: Any) {
        hint()
        if state == 0{
            wrong += 1
            
            switch wrong {
            case 3,6,9 :
                print("wrong")
            case 10 :
                print("be patient")
                wrong = 0
            default:
                print("default")
            }
        }
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
    private func action(textArray:[String]){
        let textFrame = CGRect(x: 0, y: (self.view.bounds.height - 100)/2, width: self.view.frame.width, height: 80)
        let time = TimeInterval(Float.random(in: 0.1...5))
        
        if state == 1 {
            animateAction(time: time, frame: textFrame, textArray: textArray)
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
    
    private func win(){
        let textFrame = CGRect(x: 0, y: (self.view.bounds.height - 100)/2, width: self.view.frame.width, height: 100)
        state = 4
        
        UIView.animate(withDuration: 2, delay: 0, animations: {
            self.actionBtn.layer.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            self.actionBtn.frame = CGRect(x: 0, y: 0, width: 414, height: 898)
            self.actionBtn.layer.cornerRadius = self.actionBtn.frame.width/9
        }, completion:{ finished in
            self.animateText(subtitles: self.finishText, duration: 3, animationSpacing: 0, frame: textFrame, targetLayer: self.view.layer)
        })
        
        
        
    }
}

//####################################################
// MARK: Animation
extension ViewController {
    
    func animateAction(time:TimeInterval, frame:CGRect, textArray:[String]){
        let textFrame = frame
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
                self.animateText(subtitles: [textArray[Int.random(in: 0...textArray.count-1)]], duration: 1, animationSpacing: 0, frame: textFrame, targetLayer: self.view.layer)
            }, completion: {
                finished in
                
                self.score += 1
                UIView.animateKeyframes(withDuration: TimeInterval(Float.random(in: 0.1...0.2)), delay: 1.5, animations: {
                    self.actionBtn.frame = CGRect(x: 157, y: 567, width: 121, height: 121)
                    self.actionBtn.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    self.actionBtn.layer.cornerRadius = 1
                    self.state = 0
                },completion:{ finished in
                        if self.score == self.maxScore{
                        self.win()
                        self.state = 4
                    }
                })
                
                
            })
            
        })
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


/*
 State
 0. Tutorial
 1. Action
 2. Bored
 3. Unpatience
 4. Win
 5. Result
 
 */
