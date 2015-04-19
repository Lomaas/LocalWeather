//
//  DayService.swift
//  TheCandyChallenge
//
//  Created by Simen Johannessen on 19/04/15.
//  Copyright (c) 2015 Simen Lomås Johannessen. All rights reserved.
//

import Foundation

struct Days {
    static let sunday = 1
    static let monday = 2
    static let tuesday = 3
    static let wedensday = 4
    static let thursday = 5
    static let friday = 6
    static let saturday = 7
}

struct DayService {
    
    static func getEarlyDayScreen() -> (text: String, image: String, backgroundName: String?) {
        var text: String
        var image: String
        var backgroundName: String?
        let dayOfWeek: Int = getWeekDay(NSDate())
        println("DayOf Week: \(dayOfWeek)")
        
        switch dayOfWeek {
        case Days.monday:
            println("Monday")
            image = "monday"
            text = NSLocalizedString("Its monday baby! Stay healthy, avoid spiking blood sugar, stay away from the candy, and you will be fine.", comment: "")
            backgroundName = "background3"
        case Days.tuesday:
            image = "tuesday"
            text = NSLocalizedString("Its tuesday. There are always sales on candy. You will regret i badly", comment: "")
        case Days.wedensday:
            image = "wedensday"
            text = NSLocalizedString("Sugar rush sugar crush... hope its not raining", comment: "")
        case Days.thursday:
            image = "thursday"
            text = NSLocalizedString("Its thursday! Stay healthy, avoid spiking blood sugar, stay away from the candy, and you will be fine.", comment: "")
            backgroundName = "background3"
        case Days.friday:
            image = "friday"
            text = NSLocalizedString("Aaaaah! Weekend is here. Your first real test", comment: "")
            backgroundName = "background3"
        case Days.saturday:
            image = "saturday"
            text = NSLocalizedString("Today you´ll have MASSIVE cravings for candy! Can you stay away?", comment: "")
            backgroundName = "background3"
        case Days.sunday:
            image = "sunday"
            text = NSLocalizedString("Sunday funday! Go out and enjoy the world", comment: "")
            backgroundName = "venezia"
        default:
            println("Did not match any days \(dayOfWeek)")
            fatalError("No matching weekday found")
        }
        
        return(image: image, text: text, backgroundName: backgroundName)
    }
    
    static func getLateDayScreen() -> (text: String, image: String, backgroundName: String?) {
        var text: String
        var image: String
        var backgroundName: String?
        let dayOfWeek: Int = getWeekDay(NSDate())
        
        switch dayOfWeek {
        case Days.monday:
            image = "monday"
            text = NSLocalizedString("An easy day huh? Monday isnt a problem. You just had weekend", comment: "")
        case Days.tuesday:
            image = "tuesday"
            text = NSLocalizedString("Did you see any candy offers today? And you resisted them. Well done", comment: "")
        case Days.wedensday:
            image = "wedensday"
            text = NSLocalizedString("Oh so you did avoid your coworkers well meant offer", comment: "")
        case Days.thursday:
            image = "thursday"
            text = NSLocalizedString("Bragging right is everything. ", comment: "")
        case Days.friday:
            image = "friday"
            text = NSLocalizedString("You are brilliant", comment: "")
        case Days.saturday:
            image = "saturday"
            text = NSLocalizedString("I guess you had massive CRAVINGS today I congratulate you if you made it. By the way, you owe me if you are lying", comment: "")
        case Days.sunday:
            image = "sunday"
            text = NSLocalizedString("Sunday funday! Go out and enjoy the world", comment: "")
        default:
            println("Did not match any days \(dayOfWeek)")
            fatalError("No matching weekday found")
        }
        
        return(image: image, text: text, backgroundName: backgroundName)
    }
    
    static func getWeekDay(date: NSDate) -> Int {
        let myComponents = NSCalendar.currentCalendar().component(NSCalendarUnit.WeekdayCalendarUnit, fromDate: date)
        return myComponents
    }
}