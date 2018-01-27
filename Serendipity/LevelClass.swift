//
//  LevelClass.swift
//  Serendipity
//
//  Created by Mark Cardamis on 27/1/18.
//  Copyright © 2018 Mark Cardamis. All rights reserved.
//

import Foundation

class LevelClass {
    var level:Int = 0
    
    static let shared = LevelClass()
    
    func incrementLevel() -> Int {
        if (level < 4) {
            level += 1
        }
        return level
    }
    
    func decrementLevel() -> Int {
        if (level > 0) {
            level -= 1
        }
        return level
    }
    
    func getLevel() -> Int{
        return level
    }
    
}
