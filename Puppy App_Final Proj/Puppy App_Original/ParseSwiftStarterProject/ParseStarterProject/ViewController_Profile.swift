//
//  ViewController_Profile.swift
//  Puppy App
//
//  Created by Flora Wong on 8/12/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import CoreLocation
import AVFoundation

class ViewController_Profile: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var poopCountLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var myPickerController = UIImagePickerController()
    
    let captureSession = AVCaptureSession()
    // If we find a device we'll store it here for later use
    var captureDevice : AVCaptureDevice?
    
    @IBOutlet weak var imageView: UIImageView!
  
    @IBOutlet weak var profileNameLabel: UILabel!
    
    
    @IBAction func editPhoto(sender: AnyObject) {
        
        //var photoTaking =  UIImagePickerController()
   
        let actionSheetController: UIAlertController = UIAlertController(title: "Photo", message: "Choose your puppy's profile picture", preferredStyle: .ActionSheet)
        
        //CANCEL
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        
        
        
        
        //TAKE PICTURE
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .Default) { action -> Void in
            
            //Code for launching the camera goes here

            self.myPickerController.delegate = self
            self.myPickerController.sourceType = UIImagePickerControllerSourceType.Camera
            
            self.presentViewController(self.myPickerController, animated: true, completion: nil)
        }
        
        actionSheetController.addAction(takePictureAction)
        
        
        
        
        
        
        //CHOOSE FROM CAMERA ROLL
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .Default) { action -> Void in
            
            //Code for picking from camera roll goes here
            self.myPickerController.delegate = self;
            self.myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            //show alert
            self.presentViewController(self.myPickerController, animated: true, completion: nil)

        }
        actionSheetController.addAction(choosePictureAction)
        
        //We need to provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.sourceView = sender as! UIView;
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    
    //display image picked
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        //myPickerController.dismissViewControllerAnimated(true, completion: nil)
        
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        
        self.dismissViewControllerAnimated(true, completion: {
            
            if self.imageView.image == nil {
                println("No image uploaded")
            }else{
                
                //create class for profile pics
                var profilePhotos = PFObject(className: "ProfilePics")
                profilePhotos["User"] = PFUser.currentUser()
                profilePhotos["Username"] = PFUser.currentUser()?.username
                
                //create an image data
                var profilePicData = UIImagePNGRepresentation(self.imageView.image)
                
                //create a parse file to store in cloud
                var profilePicFile = PFFile(name: "uploaded_profilepic.png", data: profilePicData)
                
                profilePhotos["ProfilePicFile"] = profilePicFile
                
                profilePhotos.saveInBackgroundWithBlock({ (success, error:NSError?) -> Void in
                    
                    if (error == nil) {
                        
                        var uploadSuccessAlert = UIAlertController(title: "Upload Success", message: "Your profile picture is successfully uploaded.", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        uploadSuccessAlert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
                        
                        self.presentViewController(uploadSuccessAlert, animated: true, completion: nil)
                        
                    } else {
                        
                        var error = String(error!.localizedDescription)
                        println(error)
                        
                        var alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title:"Close", style:UIAlertActionStyle.Default, handler:nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    
                })
            }
            
        })
    }

    //manual focus
    func focusTo(value : Float) {
        if let device = captureDevice {
            if(device.lockForConfiguration(nil)) {
                device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
                    //
                })
                device.unlockForConfiguration()
            }
        }
    }
    
//    let screenWidth = UIScreen.mainScreen().bounds.size.width
//    
//    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        var anyTouch = touches.anyObject() as! UITouch
//        var touchPercent = anyTouch.locationInView(self.view).x / screenWidth
//        focusTo(Float(touchPercent))
//    }
//    
//    func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
//        var anyTouch = touches.anyObject() as! UITouch
//        var touchPercent = anyTouch.locationInView(self.view).x / screenWidth
//        focusTo(Float(touchPercent))
//    }
    
    //modify focus
    func configureDevice() {
        if let device = captureDevice {
            device.lockForConfiguration(nil)
            device.focusMode = .Locked
            device.unlockForConfiguration()
        }
    }
    
    
    func beginSession() {
        
        configureDevice()
        
        var err : NSError? = nil
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }
        
        var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer)
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
    }
    
    //log out
    @IBAction func logOutClicked(sender: AnyObject) {
    
        if (PFUser.currentUser() != nil) {
            
            println(PFUser.currentUser()!.username)
            
            var logOutAlert = UIAlertController(title:"Log Out", message: "Aww... We will miss you.", preferredStyle: .Alert)
            
            let logOutNowAction:UIAlertAction = UIAlertAction(title: "Log Out Now", style: UIAlertActionStyle.Default, handler: { action -> Void in
                
                PFUser.logOut()
                println("+++Log Out Successful+++")
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            })

            logOutAlert.addAction(logOutNowAction)
            
            self.presentViewController(logOutAlert, animated:true, completion: nil)

        } else {
            
            println("---Log Out Unsuccessful---")
            
        }
        
    }
    
    
    
    @IBOutlet weak var profileBgImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
   
        //front camera
        captureSession.sessionPreset = AVCaptureSessionPresetLow
        
        let devices = AVCaptureDevice.devices()
       
        println(devices)

        // Loop through all the capture devices on this phone
        for device in devices {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                    //find device
                    if (captureDevice != nil) {
                        println("Capture Device Found")
                        beginSession()
                    } else {
                        println("Capture Device Not Found")
                    }
                }
            }
        }
    
        //query profile pic from profile pic class
        var photoquery = PFQuery(className: "ProfilePics")
        photoquery.whereKey("User", equalTo: PFUser.currentUser()!)
        photoquery.orderByDescending("createdAt")
        
        photoquery.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error:NSError?) -> Void in
            if (error == nil) {
                //check if there is image uploaded in profile pic class
                if (objects!.count == 0) {
                    
                    self.imageView.image == nil
                    
                }else {
                    if let objects = objects as? [PFObject] {
                        
                        if let file = objects[0]["ProfilePicFile"] as? PFFile {
                            
                            file.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
                                
                                if let imageData = imageData {
                                    
                                    self.imageView.image = UIImage(data:imageData)
                                }
                            })
                        }
                    } else {
                        println(error)
                    }
                    
                }
            }
        }

        //query markedlocation.count
        var markedLocationCount = PFQuery(className:"MarkedLocations")
        markedLocationCount.whereKey("User", equalTo: PFUser.currentUser()!)
        var rowsCount = markedLocationCount.countObjects()
        
        markedLocationCount.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error == nil) {
                println(rowsCount)
                self.poopCountLabel.text = "You have dropped " + "\(rowsCount)" + " poop(s)."
            } else {
                println(error)
            }
        }

        
        //circular profile with border
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 3.0
        self.imageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        //change name label
        profileNameLabel.text = PFUser.currentUser()?.username
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    }
