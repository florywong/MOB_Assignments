
import UIKit

class SecondViewController: UIViewController {
  
  //TODO five: Display the cumulative sum of all numbers added every time the ‘add’ button is pressed. Hook up the label, text box and button to make this work.
    
    
    @IBOutlet weak var numberTextfield: UITextField!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    
    
    var number:Int = 0
    
    @IBAction func addAction(sender: AnyObject) {
        
        var textfieldNumber = numberTextfield.text.toInt()!
        
        number = number + textfieldNumber
        
        numberLabel.text = String(number)
        
        
        
        
        
        /* This kinda worked too.
        
        var number:Int = numberTextfield.text.toInt()!
        
        var labelNumber:Int? = numberLabel?.text?.toInt()!
        
        var total = number + labelNumber!
        
        numberLabel.text = String(total)
        
        */
        
        
    }
    
    
    
    
}

