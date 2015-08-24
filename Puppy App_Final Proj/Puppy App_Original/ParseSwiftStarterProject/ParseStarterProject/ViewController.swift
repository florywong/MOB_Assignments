//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func logInClicked(sender: AnyObject) {
        
        performSegueWithIdentifier("goto_LogIn", sender: self)
        
    }
    
    @IBAction func registerClicked(sender: AnyObject) {

        performSegueWithIdentifier("goto_Register", sender: self)
        
    }
    
    
    //bg image
    var imageView: UIImageView!
    let backgroundImage = UIImage(named:"MainScreen1_2560x1600.jpg")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bg image
        imageView = UIImageView(frame:view.bounds)
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroundImage
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

    override func viewDidAppear(animated: Bool) {
        
        if (PFUser.currentUser() != nil) {
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("TabBarController_Profile") as! UIViewController
            
            self.presentViewController(vc, animated: true, completion: nil)
        
        } 
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//        //Log In + Register Button Disappear
//        UIView.animateWithDuration(0.5, animations: { () -> Void in
//            self.registerButton.alpha = 0
//            self.logInButton.alpha = 0
//        })
//
//
//        //container slowly appears
//        UIView.animateWithDuration(2, aimations: { () -> Void in
//            //self.registrationBlurLayer.alpha = 1
//            self.registrationBox.alpha = 1
//
//        })

