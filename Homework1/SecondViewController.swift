
import UIKit

class SecondViewController: UIViewController {
  
  //TODO five: Display the cumulative sum of all numbers added every time the ‘add’ button is pressed. Hook up the label, text box and button to make this work.
    
    
    @IBOutlet weak var numberTextfield: UITextField!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    
    
    
    
    @IBAction func addAction(sender: AnyObject) {
        
        var number:Int = numberTextfield.text.toInt()!
        
        var labelNumber:Int? = numberLabel?.text?.toInt()!
        
        var total = number + labelNumber!
        
        numberLabel.text = String(total)
        
        
        
    }
    
    
    
    
}







/*
var storedNumber:String = ""

var convertStoredNumber:Int = storedNumber.toInt()

var textfieldNumber:String = numberTextfield.text

var convertTextfield:Int = textfieldNumber.toInt()!

convertStoredNumber = convertStoredNumber + convertTextfield

numberLabel.text = String(convertStoredNumber)
*/
