//
//  ViewController.swift
//  Life Solution
//
//  Created by Azis Jabbar Susetio on 20/05/19.
//  Copyright © 2019 Azis Susetio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let state = 0

    @IBOutlet weak var actionBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        actionBtn.layer.cornerRadius = actionBtn.frame.width/2
        
        
    }

    @IBAction func actionBtn(_ sender: Any) {
        print("actionBTN Clicked")
        UIView.animate(withDuration: TimeInterval(Int.random(in: 1...2)), animations: {
            self.actionBtn.layer.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            self.actionBtn.frame = CGRect(x: 0, y: 0, width: 414, height: 898)
            self.actionBtn.layer.cornerRadius = 1
            
        }, completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                self.actionBtn.frame = CGRect(x: 157, y: 567, width: 121, height: 121)
                self.actionBtn.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.actionBtn.layer.cornerRadius = self.actionBtn.frame.width/2
            })
        })
    }
    
    @IBAction func blackBG(_ sender: Any) {
        print("blackBG Clicked")
        UIView.animate(withDuration: 0.1, animations: {
            self.actionBtn.layer.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            self.actionBtn.layer.opacity = 0.3
            self.actionBtn.layer.cornerRadius = 1
            
        }, completion: { finished in
            UIView.animate(withDuration: 0.5, animations: {
                self.actionBtn.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.actionBtn.layer.opacity = 1
                self.actionBtn.layer.cornerRadius = self.actionBtn.frame.width/2
            })
        })
    }
    
}

