import UIKit

var str = "Hello, playground"

var counter = 0;
var secondCounter = 0;

for (var i = 0; i < 10; i++) {
    counter += i;
    println("Counter: \(counter)");
    for j in 1...10 {
        secondCounter += j;
    }
}

let textField = UITextField(frame: CGRectMake(0, 0, 200, 50));
textField.text = "Hello";
textField.borderStyle = UITextBorderStyle.Bezel;

textField;
