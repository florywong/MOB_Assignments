
import UIKit

class ThirdViewController: UIViewController {
  /*
  TODO six: Hook up the number input text field, button and text label to this class. When the button is pressed, a message should be printed to the label indicating whether the number is even.
  
  */
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var numberTextfield: UITextField!
    
    @IBAction func calculate(sender: AnyObject) {
        
        var number:Int = numberTextfield.text.toInt()!
        
        if (number % 2 == 0) {
            
            label.text = "It is an even number"
            
        }else {
            label.text = "It is an odd number"
        }
        
        
    }
    
    
    
    
    
    
    
}
