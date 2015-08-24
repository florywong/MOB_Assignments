//
//  ViewController_Map.swift
//  Puppy App
//
//  Created by Flora Wong on 8/12/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import CoreLocation
import Parse
import MapKit


class ViewController_Map: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var manager:CLLocationManager = CLLocationManager()
    
    var lat:CLLocationDegrees = CLLocationDegrees()
    
    var long:CLLocationDegrees = CLLocationDegrees()

    var coordinates : CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var btnMarkT: UIButton!
    

    //center map to current location
    let regionRadius: CLLocationDistance = 100
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var newLocation = locations.last as! CLLocation
        
        lat = newLocation.coordinate.latitude
        long = newLocation.coordinate.longitude
        coordinates = manager.location.coordinate
        println("+++location fetched+++")
        println("Coordinates = \(lat), \(long)")
        
        manager.stopUpdatingLocation()
        
        centerMapOnLocation(newLocation)
        
        //save current location to its class for fetching current location to add pin
        var currentLocation = PFObject(className: "CurrentLocations")
        currentLocation["CheckIn"] = PFGeoPoint(latitude: lat, longitude: long)
        currentLocation["User"] = PFUser.currentUser()
        currentLocation["Username"] = PFUser.currentUser()?.username
        
        currentLocation.saveInBackgroundWithBlock { (success, error) -> Void in
            if (error == nil) {
                println("Current User: \(PFUser.currentUser()?.username)")
                println("+++location saved+++")
                
            } else {
                println(error)
            }
        }
        
        //user's current location
        let userCurrentGeoPoint = PFGeoPoint(latitude: lat, longitude: long)
        
        //query from marked locations
        var queryAllNearbyLoc = PFQuery(className: "MarkedLocations")
        
        queryAllNearbyLoc.orderByDescending("createdAt")
        
        queryAllNearbyLoc.whereKey("MarkedLocation", nearGeoPoint: userCurrentGeoPoint, withinKilometers: 5)
        
        queryAllNearbyLoc.limit = 5
        
        queryAllNearbyLoc.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error == nil) {
                if let objects = objects as? [PFObject] {
                    for object in objects {
 
                        //get indiv marked locations and save it to 'point'
                        var point = object["MarkedLocation"]as! PFGeoPoint

                        //add annotation
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude)
                        annotation.title = object["Username"] as! String
                        
                        self.mapView.addAnnotation(annotation)
 
                        println("--------Nearby Users----------")
                        println(object["Username"]!)
                        println("\(point.latitude, point.longitude)")
             
                        //store to userinfo
                        var userInfo: UserInfo = UserInfo()
                        userInfo.coordinates = point
                    }
                }
            }
        }

    }
    
    
    
    //if location fetch: failed
    func failLocationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        var error = String(error!.localizedDescription)
        println(error)
        
        var alert = UIAlertController(title: "Error Occured when Getting Current Location", message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title:"Close", style:UIAlertActionStyle.Default, handler:nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    

    
    //pin location on map
    @IBAction func mark(sender: AnyObject) {

        //query from current location to locate current position and add pin
        var currentLocationQuery = PFQuery(className: "CurrentLocations")
        
        currentLocationQuery.whereKey("User", equalTo: PFUser.currentUser()!)
        currentLocationQuery.orderByDescending("createdAt")
        
        currentLocationQuery.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error) -> Void in
            if (error == nil) {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        let point = object["CheckIn"] as! PFGeoPoint
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude)
                        annotation.title = PFUser.currentUser()?.username

                        //store it to my UserInfo class
                        var userInfo:UserInfo = UserInfo()
                        
                        userInfo.currentLocPoint = point
                        
                        var confirmAddPinAlert = UIAlertController(title: "Happy Pooping!", message: "Do you want to mark this as your territory? ", preferredStyle: UIAlertControllerStyle.Alert)
                     
                        confirmAddPinAlert.addAction(UIAlertAction(title:"YES! RUFF", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                            self.mapView.addAnnotation(annotation)
                            
                            //save marked location to parse for fetching nearby locations 
                            var markedLocation = PFObject(className: "MarkedLocations")
                            markedLocation["MarkedLocation"] = point
                            markedLocation["Username"] = PFUser.currentUser()?.username
                            markedLocation["User"] = PFUser.currentUser()
                            
                            markedLocation.saveInBackgroundWithBlock({ (success, error) -> Void in
                                if (error == nil) {
                                    println("+++marked location saved+++")
                                } else {
                                    println(error)
                                }
                            })
                        }))
                        
                        confirmAddPinAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
                        
                        self.presentViewController(confirmAddPinAlert, animated: true, completion:nil)
                
                    }
                }
            } else {
                var error = String(error!.localizedDescription)
                println(error)
                
                var alert = UIAlertController(title: "Error Occured when Adding Pin", message: error, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title:"Close", style:UIAlertActionStyle.Default, handler:nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
    }



    
    @IBOutlet weak var btnSegmentedControl: UISegmentedControl!
    
    //MAP TYPE: Standard or Satellite
    @IBAction func indexChanged(sender: AnyObject) {
        
        
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = MKMapType.Standard
        case 1:
            mapView.mapType = MKMapType.Satellite
        default:
            mapView.mapType = MKMapType.Standard
        }
    }
    

    //changing all pins to green
    func mapView(mapView: MKMapView!, viewForAnnotation annotation:MKAnnotation!) -> MKAnnotationView! {
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinColor = .Green
            pinView!.image = UIImage(named: "poop_small.png")
            
            //pinView!.canShowCallout = true
            //pinView!.image = UIImage(named: "test.png")
            
            // Add image to left callout
            var iconView = UIImageView(image: UIImage(named: "profile_small.png"))
            pinView!.leftCalloutAccessoryView = iconView
            
            // Add detail button to right callout
            var calloutButton = UIButton.buttonWithType(.DetailDisclosure) as!UIButton
            pinView!.rightCalloutAccessoryView = calloutButton
            
        }   else {
            pinView!.annotation = annotation
        }
        
        return pinView

    }
    
    
    


    
    override func viewDidLoad() {
        super.viewDidLoad()

        //show current location on map after approved
        func statusChanged(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            mapView.showsUserLocation = (status == .AuthorizedWhenInUse)
        }
        
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        
        mapView.delegate = self
        mapView.mapType = MKMapType.Standard
        mapView.showsUserLocation = true

        
        btnMarkT.layer.cornerRadius = 5
        

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
