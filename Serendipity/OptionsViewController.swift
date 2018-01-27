//
//  OptionsViewController.swift
//  Serendipity
//
//  Created by Mark Cardamis on 25/1/18.
//  Copyright © 2018 Mark Cardamis. All rights reserved.
//
protocol LevelsDelegate : class{
    func sendCompleted(done: Bool)
}

import UIKit

class OptionsViewController: UIViewController {
    
    var levelNumber:Int?
    var LevelsHeading = [String]()
    var LevelsData = [[String]]()
    weak var delegate: LevelsDelegate?

    @IBOutlet weak var buttonUp: UIButton!
    @IBOutlet weak var buttonDown: UIButton!
    @IBOutlet weak var levelHeading: UILabel!
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LevelsData = DataProvider().loadInfo()
        LevelsHeading = DataProvider().loadInfoHeadings()
        buttonPlay.layer.cornerRadius = 2
        imageBackground.layer.cornerRadius = 2
        buttonUp.imageEdgeInsets=UIEdgeInsetsMake(35, 35, 35, 35);
        buttonDown.imageEdgeInsets=UIEdgeInsetsMake(35, 35, 35, 35);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        levelNumber = LevelClass.shared.getLevel()
        showLevelText(levelNumber: levelNumber!)
        showHideLevelButtons()
        self.showAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func levelUp(_ sender: UIButton) {
        levelNumber = LevelClass.shared.incrementLevel()
        showLevelText(levelNumber: levelNumber!)
        showHideLevelButtons()
    }
    
    @IBAction func levelDown(_ sender: UIButton) {
        levelNumber = LevelClass.shared.decrementLevel()
        showLevelText(levelNumber: levelNumber!)
        showHideLevelButtons()
    }
    
    func showLevelText (levelNumber:Int) {
        var str:String=""
        for i in 0...4 {
            str += ("\(i+1). \(LevelsData[levelNumber][i])\n")
        }
            str += ("6. \(LevelsData[levelNumber][5])")
        levelLabel.text = "\(str)"
        levelHeading.text = ("\(LevelsHeading[levelNumber])")
    }
    
    
    @IBAction func closePopUp(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    func showHideLevelButtons() {
        if (levelNumber == 0) {
            buttonDown.isHidden = true
        } else  if (levelNumber == 4) {
            buttonUp.isHidden = true
        } else {
            buttonUp.isHidden = false
            buttonDown.isHidden = false
        }
        
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
                self.delegate?.sendCompleted(done: true)
                self.view.removeFromSuperview()
            }
        });
    }
    
}
