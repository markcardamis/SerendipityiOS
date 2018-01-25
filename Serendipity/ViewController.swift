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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Press1(_ sender: UIButton) {
    }
    @IBAction func Press2(_ sender: UIButton) {
    }
    @IBAction func Press3(_ sender: UIButton) {
    }
    @IBAction func Press4(_ sender: UIButton) {
    }
    @IBAction func Press5(_ sender: UIButton) {
    }
    @IBAction func Press6(_ sender: UIButton) {
    }
    
    @IBAction func DiceRoll(_ sender: UIButton) {
        
        let diceNumber = arc4random_uniform(6) + 1
        
        DiceImage.image = UIImage(named: "\(diceNumber)")
    
    }
    
    
}

