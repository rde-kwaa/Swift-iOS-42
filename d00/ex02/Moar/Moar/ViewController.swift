//
//  ViewController.swift
//  Moar
//
//  Created by Ryan de Kwaadsteniet on 10/7/19.
//  Copyright © 2019 Ryan de Kwaadsteniet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var labelOut: UILabel!
    
    @IBAction func button0(_ sender: Any, forEvent event: UIEvent) {
        labelOut.text = "0"
        print("Input for 0")
    }
    @IBAction func button1(_ sender: Any, forEvent event: UIEvent) {
        labelOut.text = "1"
        print("Input for 1")
    }
    @IBAction func button2(_ sender: Any, forEvent event: UIEvent) {
        labelOut.text = "2"
        print("Input for 2")
    }
    @IBAction func button3(_ sender: Any, forEvent event: UIEvent) {
        labelOut.text = "3"
        print("Input for 3")
    }
    @IBAction func button4(_ sender: Any, forEvent event: UIEvent) {
        labelOut.text = "4"
        print("Input for 4")
    }
    @IBAction func button5(_ sender: Any, forEvent event: UIEvent) {
        labelOut.text = "5"
        print("Input for 5")
    }
    @IBAction func button6(_ sender: Any, forEvent event: UIEvent) {
        labelOut.text = "6"
        print("Input for 6")
    }
    @IBAction func button7(_ sender: Any, forEvent event: UIEvent) {
        labelOut.text = "7"
        print("Input for 7")
    }
    @IBAction func button8(_ sender: Any, forEvent event: UIEvent) {
        labelOut.text = "8"
        print("Input for 8")
    }
    @IBAction func button9(_ sender: Any, forEvent event: UIEvent) {
        labelOut.text = "9"
        print("Input for 9")
    }
    @IBAction func buttonEquals(_ sender: Any, forEvent event: UIEvent) {
        print("Compute the operation with 2 operands")
    }
    @IBAction func buttonComma(_ sender: Any, forEvent event: UIEvent) {
        print("Adds a placeholder for decimal numbers")
    }
    @IBAction func buttonPlus(_ sender: Any, forEvent event: UIEvent) {
        print("Operator for Addition")
    }
    @IBAction func buttonMinus(_ sender: Any, forEvent event: UIEvent) {
        print("Operator for Minus")
    }
    @IBAction func buttonMultiply(_ sender: Any, forEvent event: UIEvent) {
        print("Operator for Multiply")
    }
    @IBAction func buttonDivide(_ sender: Any, forEvent event: UIEvent) {
        print("Operator for Divide")
    }
    @IBAction func buttonReset(_ sender: Any, forEvent event: UIEvent) {
        print("Resets calculator")
    }
    @IBAction func buttonNeg(_ sender: Any, forEvent event: UIEvent) {
        print("Changes the sign of the current number")
    }
    @IBAction func buttonPercent(_ sender: Any, forEvent event: UIEvent) {
        print("Divides by 100")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

