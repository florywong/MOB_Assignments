//
//  LogInViewController.swift
//  Puppy App
//
//  Created by Flora Wong on 8/8/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!

    @IBAction func verify(sender: AnyObject) {

        
        println("Log In Clicked")
        
        PFUser.logInWithUsernameInBackground(usernameTextfield.text, password: passwordTextfield.text) { (user, error) -> Void in
            if (user != nil) {
            
            println("User & Password Verified: Pass")
            
        self.performSegueWithIdentifier("goto_Profile", sender: self)
                
            } else {
                
                var alert = UIAlertController(title: "Wrong Username or Password", message: "Please enter again.", preferredStyle: .Alert)
                
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion:nil)
                
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
        
        println(PFUser.currentUser())
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
