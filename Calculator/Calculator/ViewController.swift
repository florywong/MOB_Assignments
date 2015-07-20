//
//  ViewController.swift
//  Calculator
//
//  Created by Flora Wong on 7/14/15.
//  Copyright (c) 2015 Flora Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var firstNumber:Double = 0
    var secondNumber:Double = 0
    var result:Double = 0
    var operation:String = ""
    var isTypingNumber = false
    
   
    
    @IBAction func number(sender: AnyObject) {
        
        var numberPressed = sender.currentTitle
        
        if count(display.text!) < 11 {
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .DecimalStyle
            formatter.locale = NSLocale.currentLocale()
            formatter.maximumFractionDigits = 10
            
            if isTypingNumber == true {
                display.text = display.text! + numberPressed!!
            } else {
                display.text = numberPressed!
            }
            isTypingNumber = true
            
            display.text = formatter.stringFromNumber((display.text!.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions(), range: nil) as NSString).doubleValue)
        }
 
        //println(sender.currentTitle)
        //replaceAdd(sender.currentTitle!!)
        //println(sender.currentTitle)
    }
    
    @IBAction func dot(sender: AnyObject) {
        var dot = sender.currentTitle
        if isTypingNumber == true {
            display.text = display.text! + dot!!
        }
    }
    
    @IBAction func operation(sender: AnyObject) {
        isTypingNumber = false
        operation = sender.currentTitle!!
        firstNumber = (display.text! as NSString).doubleValue
    }
    
    @IBAction func equal(sender: AnyObject) {
        
        secondNumber = (display.text! as NSString).doubleValue
        println(secondNumber)
        
        if operation == "+" {
            result = (firstNumber + secondNumber)
        } else if operation == "-" {
            result = (firstNumber - secondNumber)
        } else if operation == "x" {
            result = (firstNumber * secondNumber)
        } else {
            result = (firstNumber / secondNumber)
        }
        println(result)
        display.text = String(stringInterpolationSegment: result)
        
        firstNumber = result
    }
    
    @IBAction func pToN(sender: AnyObject) {
        var toNegative = ((display.text! as NSString).doubleValue) * -1
        result = toNegative
        display.text = String(stringInterpolationSegment: result)
    }
    
    @IBAction func percentage(sender: AnyObject) {
        var toPercentage = ((display.text! as NSString).doubleValue / 100)
        result = toPercentage
        display.text = String(stringInterpolationSegment:result)
    }
    
    @IBAction func clear(sender: AnyObject) {
        display.text = "0"
        firstNumber = 0
        secondNumber = 0
        result = 0
        isTypingNumber = false
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    func replaceAdd(numberPressed:String) {
    
    if count(display.text!) < 11 {
    let formatter = NSNumberFormatter()
    formatter.numberStyle = .DecimalStyle
    formatter.locale = NSLocale.currentLocale()
    formatter.maximumFractionDigits = 10
    
    if isTypingNumber == true {
    display.text = display.text! + numberPressed
    } else {
    display.text = numberPressed
    }
    isTypingNumber = true
    
    var displayFirstNumber:Double = (display.text!.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil) as NSString).doubleValue
    
    firstNumber = displayFirstNumber
    
    display.text = formatter.stringFromNumber(displayFirstNumber)
    
    }
    
    }
    */
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

