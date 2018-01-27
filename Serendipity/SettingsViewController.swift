//
//  OptionsViewController.swift
//  Serendipity
//
//  Created by Mark Cardamis on 25/1/18.
//  Copyright © 2018 Mark Cardamis. All rights reserved.
//
protocol SettingsDelegate : class{
    func levelStatus(done: Bool)
}

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var switchState: UISwitch!
    @IBOutlet weak var levelSelectedText: UILabel!
    weak var delegate: SettingsDelegate?
    var levelSelected:Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        levelSelected = UserDefaults.standard.bool(forKey: "identifier")
        switchState.isOn = levelSelected
        if (levelSelected) {
            levelSelectedText.text = "Show levels"
        } else {
            levelSelectedText.text = "Hide levels"
        }
        self.showAnimate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleLevels(_ sender: UISwitch) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(switchState.isOn, forKey:"identifier")
        userDefaults.synchronize()
        
        if switchState.isOn {
            levelSelected = true
            levelSelectedText.text = "Show levels"
        } else {
            levelSelected = false
            levelSelectedText.text = "Hide levels"
        }
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
                self.delegate?.levelStatus(done: self.levelSelected)
                self.view.removeFromSuperview()
            }
        });
    }
    
}

