//
//  OptionsViewController.swift
//  Serendipity
//
//  Created by Mark Cardamis on 25/1/18.
//  Copyright © 2018 Mark Cardamis. All rights reserved.
//
protocol TodoDelegate : class{
    func sendCompleted(done: Bool)
}

import UIKit

class OptionsViewController: UIViewController {
    
    var levelNumber:Int?
    var LevelsData = [[String]]()
    weak var delegate: TodoDelegate?

    @IBOutlet weak var levelLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LevelsData = DataProvider().loadInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        levelNumber = LevelClass.shared.getLevel()
        showLevelText(levelNumber: levelNumber!)
        self.showAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func levelUp(_ sender: UIButton) {
        levelNumber = LevelClass.shared.incrementLevel()
        showLevelText(levelNumber: levelNumber!)
    }
    
    @IBAction func levelDown(_ sender: UIButton) {
        levelNumber = LevelClass.shared.decrementLevel()
        showLevelText(levelNumber: levelNumber!)
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
                self.delegate?.sendCompleted(done: true)
            }
        });
    }
    
}
