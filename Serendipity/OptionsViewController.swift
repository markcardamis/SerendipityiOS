//
//  OptionsViewController.swift
//  Serendipity
//
//  Created by Mark Cardamis on 25/1/18.
//  Copyright © 2018 Mark Cardamis. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    
    var level:Int = 0
    var LevelsData = [[String]]()

    @IBOutlet weak var levelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAnimate()
        let theDataHolding = DataProvider()
        LevelsData = theDataHolding.loadInfo()
        showLevelText(levelNumber: level)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func levelUp(_ sender: UIButton) {
        if (level < 4) {
            level += 1
            showLevelText(levelNumber: level)
        }

    }
    @IBAction func levelDown(_ sender: UIButton) {
        if (level > 0) {
            level -= 1
            showLevelText(levelNumber: level)
        }
        
    }
    
    func showLevelText (levelNumber:Int) {
        var str:String=""
        for i in 0...5 {
            str += ("\(i+1). \(LevelsData[levelNumber][i])\n")
        }
            levelLabel.text = "\(str)"
        }
    
    
    @IBAction func closePopUp(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
}
