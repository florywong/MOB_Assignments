//
//  RegisterViewController.swift
//  Puppy App
//
//  Created by Flora Wong on 8/12/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var registrationContainer: UIView!

    @IBAction func cancelRegistration(sender: AnyObject) {
        println("maybe later pressed")
        performSegueWithIdentifier("goto_Main", sender: self)
    }
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBAction func ruffRegister(sender: AnyObject) {
        
        var user = PFUser()
        user.email = emailTextfield.text
        user.username = usernameTextfield.text
        user.password = passwordTextfield.text
        
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            if (error == nil) {
                    
                //alert popup
                var alert = UIAlertController(title: "Registration Successful", message: "You are officially in the Ruff community.", preferredStyle: .Alert)
                    
                    
                let logInNowAction: UIAlertAction = UIAlertAction(title: "Log In Now", style: UIAlertActionStyle.Default) { action -> Void in
                    
                let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    
                let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("TabBarController_Profile") as! UIViewController
                    
                self.presentViewController(vc, animated: true, completion: nil)
            }
                    
                alert.addAction(logInNowAction)

                //show alert
                self.presentViewController(alert, animated: true, completion:nil)
                    
                println("+++New Member Registration Successful+++")
                    
            } else {
                
                var error = String(error!.localizedDescription)
                println(error)
                
                var alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title:"Close", style:UIAlertActionStyle.Default, handler:nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        }

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
        
        // Add blur view
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = imageView.bounds
        visualEffectView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        visualEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
        imageView.addSubview(visualEffectView)
        imageView.sendSubviewToBack(visualEffectView)
        

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

