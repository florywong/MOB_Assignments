//
//  ViewController.swift
//  Lesson 15 - Weather Forecast
//
//  Created by Flora Wong on 7/22/15.
//  Copyright (c) 2015 Flora Wong. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager = CLLocationManager()
    
    var lat:CLLocationDegrees = CLLocationDegrees()
    
    var long:CLLocationDegrees = CLLocationDegrees()
    
    @IBOutlet weak var tomTempLabel: UILabel!
    
    
    @IBOutlet weak var forecastIcon: UIImageView!
    
    func getForecast () {
        
        var url = "http://api.openweathermap.org/data/2.5/forecast/daily"
        
        var params = [
            "lat":lat, "lon":long, "units":"metric", "cnt":5]
        
        request(.GET, url, parameters:params as? [String : AnyObject]).responseJSON { request, response, data, error in
            
            println(url)
            
            if (error != nil) {
                println(error)
            }else {
                var resp = JSON(data!)
                
                var tomtemp = resp["list"][1]["temp"]["day"].double
                println(tomtemp)
                
                if let tomt = tomtemp {
                    self.tomTempLabel.text = String(format:"%.0f", tomt) + "℃"
                }
                
                 var icon = resp["list"][1]["weather"][0]["icon"].string
                
                if let url1:NSURL = NSURL(string: "http://openweathermap.org/img/w/" + icon! + ".png"){
                    if let data = NSData(contentsOfURL: url1) {
                        
                        self.forecastIcon.contentMode = UIViewContentMode.ScaleAspectFit
                        self.forecastIcon.image = UIImage(data:data)
                    }
                    
                }
                
                
            }
    }

        
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        
        lat = newLocation.coordinate.latitude
        long = newLocation.coordinate.longitude
        
        println(lat)
        println(long)
        
        getWeather()
        getForecast()
        
        manager.stopUpdatingLocation()
        
    }
    
    func getWeather () {
        var url = "http://api.openweathermap.org/data/2.5/weather"
        
        var params = [
            "lat":lat, "lon":long, "units":"metric"
        ]
        
        
        request(.GET, url, parameters:params as? [String : AnyObject]).responseJSON { request, response, data, error in
            
            println(url)
            
            if (error != nil) {
                println(error)
            }else {
                var resp = JSON(data!)
                
                var temp = resp["main"]["temp"].double
                println(temp)
                
                if let t = temp {
                    self.tempLabel.text = String(format:"%.0f", t) + "℃"
                }
                
                var icon = resp["weather"][0]["icon"].string
                
                println(icon)
                
                if let url1:NSURL = NSURL(string: "http://openweathermap.org/img/w/" + icon! + ".png"){
                    if let data = NSData(contentsOfURL: url1) {
                        
                        self.weatherIcon.contentMode = UIViewContentMode.ScaleAspectFit
                        self.weatherIcon.image = UIImage(data:data)
                    }
                    
                }
                
                var location = resp["name"].string
                
                if let l = location {
                    self.locationLabel.text = l
                }
                
                
                var description = resp["weather"][0]["description"].string
                
                if let d = description {
                    self.descriptionLabel.text = d
                }
            }
            
        }
        
    }
    
    let backgroundImage = UIImage(named:"sky 1.jpg")
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        var backImage = UIImage(named:"sky 1.jpg")
        
        var resizable = backImage?.resizableImageWithCapInsets(UIEdgeInsets(top:10, left:0, bottom:10, right:0))
            
        self.view.backgroundColor = UIColor(patternImage: resizable!)
       */
        imageView = UIImageView(frame:view.bounds)
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroundImage
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        
        
        
            
        manager.requestWhenInUseAuthorization()
        
        manager.delegate = self
        
        manager.startUpdatingLocation()
        
        
    }
    
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

