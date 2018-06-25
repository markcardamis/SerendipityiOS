//
//  WalkthroughViewController.swift
//  Serendipity
//
//  Created by Mark Cardamis on 25/1/18.
//  Copyright © 2018 Mark Cardamis. All rights reserved.
//

protocol WalkthroughDelegate : class{
    func sendWalkthroughCompleted(done: Bool)
}

import UIKit

class WalkthroughViewController: UIViewController {
    
    var levelNumber = 0
    var levelHeadings = "Screenshot intro"
    weak var delegate: WalkthroughDelegate?
    
    @IBOutlet weak var buttonUp: UIButton!
    @IBOutlet weak var buttonDown: UIButton!
    @IBOutlet weak var levelHeading: UILabel!
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var levelPageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonPlay.layer.cornerRadius = 3
        imageBackground.layer.cornerRadius = 3
        buttonUp.imageEdgeInsets=UIEdgeInsetsMake(35, 35, 35, 35);
        buttonDown.imageEdgeInsets=UIEdgeInsetsMake(35, 35, 35, 35);
        self.levelPageControl.numberOfPages = 4
        self.levelPageControl.currentPage = 0
        showHideLevelButtons()
        levelHeading.text = levelHeadings
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showAnimate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SwipeRight(_ sender: UISwipeGestureRecognizer) {
        levelNumber = levelNumber - 1
        showHideLevelButtons()
    }
    
    @IBAction func levelUp(_ sender: UIButton) {
        levelNumber = levelNumber + 1
        showHideLevelButtons()
    }
    
    @IBAction func levelUpButton(_ sender: Any) {
        levelNumber = levelNumber + 1
        showHideLevelButtons()
    }
    
    @IBAction func SwiftLeft(_ sender: UISwipeGestureRecognizer) {
        levelNumber = levelNumber + 1
        showHideLevelButtons()
    }
    
    @IBAction func levelDownButton(_ sender: Any) {
        levelNumber = levelNumber - 1
        showHideLevelButtons()
    }
    
    @IBAction func levelDown(_ sender: UIButton) {
        levelNumber = levelNumber - 1
        showHideLevelButtons()
    }

    
    @IBAction func closePopUp(_ sender: UIButton) {
        self.removeAnimate()
    }
    
    func showHideLevelButtons() {
        if (levelNumber <= 0) {
            buttonDown.isHidden = true
            buttonUp.isHidden = false
            levelNumber = 0
        } else if (levelNumber >= 3) {
            buttonDown.isHidden = false
            buttonUp.isHidden = true
            levelNumber = 3
        } else {
            buttonUp.isHidden = false
            buttonDown.isHidden = false
        }
        imageBackground.image = UIImage(named: "step_\(levelNumber+1)")
        self.levelPageControl.currentPage = levelNumber
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
        
        self.buttonDown.alpha = 1
        self.buttonUp.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0.5,
                       options: [UIViewAnimationOptions.curveLinear,                                                                UIViewAnimationOptions.repeat,                                                                 UIViewAnimationOptions.autoreverse], animations: {
            self.buttonDown.alpha = 0.6
            self.buttonUp.alpha = 0.6
        }, completion: nil)
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.delegate?.sendWalkthroughCompleted(done: true)
                self.view.removeFromSuperview()
            }
        });
    }
    
}
