//
//  DataProvider.swift
//  Serendipity
//
//  Created by Mark Cardamis on 25/1/18.
//  Copyright © 2018 Mark Cardamis. All rights reserved.
//

import Foundation


public class DataProvider {
    
    var Levels = [[String]]()
    var LevelHeadings = [String]()
    
    
    public func loadInfoHeadings() -> [String]
    {
        let levelHeadings = ["Lets play",
                             "Two left feet",
                             "Take a chance",
                             "You did what!",
                             "It better be love"]
        
        return levelHeadings
    }
    
    
    public func loadInfo() -> [[String]]
    {

        let Level_1 = ["When was your last embarrassing moment?",
                       "In what way would you like to be famous?",
                       "What is an interesting fact about yourself?",
                       "What is a perfect day for you?",
                       "Do a shot together",
                       "What is your nickname?"]
        
        let Level_2 = ["When did you last laugh uncontrollably",
                       "Show off 1 dance move",
                       "What does friendship mean to you?",
                       "What is your favourite part of your body?",
                       "What colour underwear are you both wearing?",
                       "Tell your date something you like about them"]
        
        let Level_3 = ["Get as close to each other without kissing",
                       "Hold hands for 30 seconds",
                       "Walk to another area holding hands",
                       "Kiss on the neck/ear",
                       "When did you last masturbate? (don't lie)",
                       "Introduce yourself to a stranger as a couple"]
        
        let Level_4 = ["What is your favourite sex position?",
                       "Do a tequila shot",
                       "Flash your underwear to each other",
                       "Kiss gently for 10 seconds",
                       "Ask a naughty question",
                       "Run fingers across partner's lips"]
        
        let Level_5 = ["Organise date/time for another date",
                       "Go to the dance floor and move seductively",
                       "Kiss passionately for 10 seconds",
                       "Buy your date flowers and chocolate",
                       "It's time to go.... alone",
                       "Go back to your place and make your own list"]
        
        Levels.append(Level_1)
        Levels.append(Level_2)
        Levels.append(Level_3)
        Levels.append(Level_4)
        Levels.append(Level_5)
        
        return Levels
    
    }
    
    
}

