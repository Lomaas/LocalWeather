//
//  DayViewController.swift
//  TheCandyChallenge
//
//  Created by Simen Johannessen on 11/04/15.
//  Copyright (c) 2015 Simen Lomås Johannessen. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class DayViewController: UIViewController, WeatherServiceDelegate, CLLocationManagerDelegate {
    var blueCloud: UIImageView?
    let weatherService = WeatherService()
    let locationManager = CLLocationManager()

    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var mainWeatherImage: UIImageView!
    @IBOutlet weak var mainText: UILabel!

    @IBOutlet weak var authorName: UILabel!
    @IBAction func interactionButtonPressed(sender: UIButton) {
        println("Interaction button pressed")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherService.delegate = self
        weatherService.startFetchingWeather()
        
        isEarlyDay() ? showEarlyDayScreen() : showLateDayScreen()
    }
        
    func isCloudy() -> Bool {
        return true
    }
    
    func isSunny() -> Bool {
        return false
    }
    
    func isEarlyDay() -> Bool {
        let components = NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitSecond | NSCalendarUnit.CalendarUnitMinute
        let date = NSCalendar.currentCalendar().components(components, fromDate: NSDate())
        return date.hour >= 21 ? false : true
    }
    
    // MARK: Show and add views
    
    func showSun() {
        mainWeatherImage.image = UIImage(named: "sunandcloud")
    }
    
    func showClouds() {
        for x in 0...5 {
            addNewCloud()
        }
    }
    
    func showClearWeather() {
        
    }
    
    func showRain() {
        var updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "addNewRainDrop", userInfo: nil, repeats: true)
    }
    
    func addNewCloud() {
        let size = Int.random(50...140)
        let cloud =  UIImageView(frame: CGRectMake(CGFloat(-140), CGFloat(Int.random(20...150)), CGFloat(size), CGFloat(size)))
        cloud.alpha = 0.8
        cloud.image = UIImage(named: "bluecloud")
        cloud.contentMode = .ScaleAspectFit
        cloud.layer.zPosition = 1;
        self.view.addSubview(cloud)
        
        animateCloud(cloud)
    }
    
    
    func addNewRainDrop() {
        let rainView = RainView(frame: self.view.bounds)
        rainView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(rainView)
        self.view.sendSubviewToBack(rainView)
        self.animateRain(rainView)
    }
    
    // MARK: - animation
    
    func animateCloud(view: UIImageView) {
        let delay = Int.random(0...7)
        let duration = Int.random(13...15)
        animateFrame(view, duration: Double(duration), delay: Double(delay), completion: { (finished) -> Void in
                view.removeFromSuperview()
                self.addNewCloud()
        })
    }
    
    func animateRain(view: RainView) {
        UIView.animateWithDuration(4, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
            var viewFrame = view.frame
            viewFrame.origin.y = self.view.frame.size.height
            view.frame = viewFrame
            }, completion: { finished in
                view.removeFromSuperview()
        })
    }
    
    func animateFrame(view: UIView, duration: Double, delay: Double, completion: (finished: Bool) -> Void) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveLinear, animations: {
            var viewFrame = view.frame
            viewFrame.origin.x = self.view.frame.size.width
            view.frame = viewFrame
            }, completion: { finished in
                completion(finished: finished)
        })
    }
    
    func updateView(imageName: String, text: String, backgroundName: String?, author: String) {
        headerImage.image = UIImage(named: imageName)
        mainText.text = text
        authorName.text = author
    }
    
    func showEarlyDayScreen() {
        var text: String
        var image: String
        var author: String
        var backgroundName: String?

        self.view.backgroundColor = UIColor(red: 6.0/255.0, green: 138.0/255.0, blue: 194.0/255.0, alpha: 0.5)
        mainText.textColor = UIColor.blackColor()
        authorName.textColor = UIColor.blackColor()
        (text, image, backgroundName, author) = DayService.getEarlyDayScreen()
        updateView(image, text: text, backgroundName: backgroundName, author: author)
    }
    
    func showLateDayScreen() {
        var text: String
        var image: String
        var author: String
        var backgroundName: String?
        
        self.view.backgroundColor = UIColor(red: 44.0/255.0, green: 62/255.0, blue: 80/255.0, alpha: 1)
        mainWeatherImage.image = UIImage(named: "moon")
        mainText.textColor = UIColor.whiteColor()
        authorName.textColor = UIColor.whiteColor()
        (text, image, backgroundName, author) = DayService.getLateDayScreen()
        updateView(image, text: text, backgroundName: backgroundName, author: author)
    }
    
    func localWeather(weather: Weather, temp: Double) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            self.temperature.text = String(format:"%.1f", temp) + "℃"
            
            switch weather {
            case Weather.clear:
                println("Weather is clear")
                self.showClearWeather()
            case Weather.sunny:
                self.showSun()
            case Weather.cloudy:
                self.showClouds()
            case Weather.rain:
                self.showRain()
            default:
                println("Weather view not implemented yet")
            }
        })
    }
}