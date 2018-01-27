//
//  ViewController.swift
//  Serendipity
//
//  Created by Mark Cardamis on 25/1/18.
//  Copyright © 2018 Mark Cardamis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var DiceImage: UIImageView!
    
    var timer:Timer? = nil
    var times:Int = 0
    var selectNumber:Int = 0
    var diceRolling = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
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
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)

    }
    
    
    func startTimer() {
        diceRolling = true
        timer = Timer.scheduledTimer(timeInterval: 0.25 ,
                                     target: self,
                                     selector: (#selector(ViewController.onTick)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func onTick(timer:Timer){
        times += 1
        
        if times > 8 {  // clear the timer after 2 seconds
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
    }
    
    func displayRandomImage(){
        let diceNumber = arc4random_uniform(6) + 1
        DiceImage.image = UIImage(named: "Dice\(diceNumber)")
    }
    
    func displaySetImage(diceNumber:Int){
        DiceImage.image = UIImage(named: "Dice\(diceNumber)")
    }
    
    
}

