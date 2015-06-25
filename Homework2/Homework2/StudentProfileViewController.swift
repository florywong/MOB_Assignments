//
//  StudentProfileViewController.swift
//  Homework2
//
//  Created by Kannan Chandrasegaran on 25/6/15.
//  Copyright (c) 2015 Kannan Chandrasegaran. All rights reserved.
//

import UIKit

class StudentProfileViewController: UIViewController {

    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var averageScoreLabel: UILabel!
    @IBOutlet weak var allScoresLabel: UILabel!
    @IBOutlet weak var phonenumberLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var student:Student = Student()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO3
        firstnameLabel.text = student.firstName
        lastnameLabel.text = student.lastName
        ageLabel.text = String(student.age)
        allScoresLabel.text = String(stringInterpolationSegment: student.scores)
        
        
        //TODO5
        var studentScores = student.scores
        
        var sumOfScores = reduce(studentScores, 0, +)
        
        println(sumOfScores)
        
        var averageScores = (sumOfScores / 4)
        
        averageScoreLabel.text = String(averageScores)
        
        
        //TODO6
        var phoneNumber = student.phoneNumber
        
        if let phoneNum = student.phoneNumber {
            
            phonenumberLabel.text = String(phoneNum)
            
        } else {
            
            phonenumberLabel.text = "NIL"
        }
        
     
        //TODO7
        if let url = NSURL(string: student.profilePicURL), data = NSData(contentsOfURL: url) {
            
            image.image = UIImage(data: data)
            
        }
        

        
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
