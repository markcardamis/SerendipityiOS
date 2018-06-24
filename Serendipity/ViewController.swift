//
//  ViewController.swift
//  Serendipity
//
//  Created by Mark Cardamis on 25/1/18.
//  Copyright © 2018 Mark Cardamis. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, LevelsDelegate, SettingsDelegate, WalkthroughDelegate {

    @IBOutlet weak var DiceImage: UIImageView!
    @IBOutlet weak var bOptionsText: UIButton!
    @IBOutlet weak var tapDiceLabel: UILabel!
    
    var timer:Timer? = nil
    var times:Int = 0
    var selectNumber:Int = 0
    var diceRolling = false
    var levelNumber:Int?
    var LevelsData = [[String]]()
    var LevelsHeading = [String]()
    var DiceRollingSound: AVAudioPlayer?
    var levelSelected = true
    var walkthroughRun:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        LevelsData = DataProvider().loadInfo()
        LevelsHeading = DataProvider().loadInfoHeadings()
        bOptionsText.layer.cornerRadius = 3
        bOptionsText.titleLabel?.minimumScaleFactor = 0.5
        bOptionsText.titleLabel?.numberOfLines = 1
        bOptionsText.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    

    @objc func appMovedToBackground() {
        LevelClass.shared.level = 0
        tapDiceLabel.isHidden = false
        DiceImage.image = UIImage(named: "dice3droll")
        bOptionsText.setTitle("[Show Options]", for: .normal)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        levelNumber = LevelClass.shared.getLevel()
        levelSelected = UserDefaults.standard.bool(forKey: "identifier")
        if (levelSelected) {
            bOptionsText.isHidden = false
            levelNumber = LevelClass.shared.getLevel()
            bOptionsText.setTitle((LevelsHeading[levelNumber!]), for: .normal)
        } else {
            bOptionsText.isHidden = true
        }
//        walkthroughRun = UserDefaults.standard.bool(forKey: "walkthrough")
//        if (!walkthroughRun) {
//            UserDefaults.standard.set(true, forKey:"walkthrough")
//            UserDefaults.standard.synchronize()
//            walkThrough((Any).self)
//        }
    }
    
    func sendCompleted(done: Bool) {
        levelNumber = LevelClass.shared.getLevel()
        bOptionsText.setTitle((LevelsHeading[levelNumber!]), for: .normal)
    }
    
    func levelStatus(done: Bool) {
        levelSelected = done
        if (levelSelected) {
            bOptionsText.isHidden = false
            levelNumber = LevelClass.shared.getLevel()
            bOptionsText.setTitle((LevelsHeading[levelNumber!]), for: .normal)
        } else {
            bOptionsText.isHidden = true
        }
        walkthroughRun = UserDefaults.standard.bool(forKey: "walkthrough")
        if (!walkthroughRun) {
            UserDefaults.standard.set(true, forKey:"walkthrough")
            UserDefaults.standard.synchronize()
            walkThrough((Any).self)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Press1(_ sender: UIButton) {
        selectNumber = 1
    }
    @IBAction func Press2(_ sender: UIButton) {
        selectNumber = 2
    }
    @IBAction func Press3(_ sender: UIButton) {
        selectNumber = 3
    }
    @IBAction func Press4(_ sender: UIButton) {
        selectNumber = 4
    }
    @IBAction func Press5(_ sender: UIButton) {
        selectNumber = 5
    }
    @IBAction func Press6(_ sender: UIButton) {
        selectNumber = 6
    }
    
    @IBAction func DiceRoll(_ sender: UIButton) {
        if (!diceRolling) {
            startTimer()
        }
    }
    
    @IBAction func bOptions(_ sender: UIButton) {
        let popOverVC = UIStoryboard(name: "Options", bundle: nil).instantiateViewController(withIdentifier: "OptionsViewController") as! OptionsViewController
        popOverVC.delegate = self
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)

    }
    
    @IBAction func bInfo(_ sender: UIButton) {
        let popOverVC = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        popOverVC.delegate = self
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    @IBAction func walkThrough(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Walkthrough", bundle: nil).instantiateViewController(withIdentifier: "WalkthroughViewController") as! WalkthroughViewController
        popOverVC.delegate = self
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    
    func startTimer() {
        diceRolling = true
        tapDiceLabel.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 0.25 ,
                                     target: self,
                                     selector: (#selector(ViewController.onTick)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func onTick(timer:Timer){
        times += 1
    
        if times > 6 {  // clear the timer after 1.5 seconds
            times = 0
            timer.invalidate()
            diceRolling = false
            if (selectNumber == 0){
                displayRandomImage()
            } else {
                displaySetImage(diceNumber: selectNumber)
                selectNumber = 0
            }
            
        } else {
            displayRandomImage()
        }
        
        if (times == 1) { // play sound after first images loaded
            playDiceSound()
        }
    }
    
    func displayRandomImage(){
        let diceNumber = Int(arc4random_uniform(6) + 1)
        DiceImage.image = UIImage(named: "Dice\(diceNumber)")
        if (!diceRolling) {
            bOptionsText.setTitle((LevelsData[levelNumber!][diceNumber-1]), for: .normal)
        }
    }
    
    func displaySetImage(diceNumber:Int){
        DiceImage.image = UIImage(named: "Dice\(diceNumber)")
        if (!diceRolling){
            bOptionsText.setTitle((LevelsData[levelNumber!][diceNumber-1]), for: .normal)
        }
    }
    
    func playDiceSound() {
        let path = Bundle.main.path(forResource: "shake_dice.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            DiceRollingSound = try AVAudioPlayer(contentsOf: url)
            DiceRollingSound?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    
}

