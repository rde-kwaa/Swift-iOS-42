//
//  ViewController.swift
//  Moar
//
//  Created by Ryan de Kwaadsteniet on 10/7/19.
//  Copyright © 2019 Ryan de Kwaadsteniet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentNum:Double = 0
    var currentTotal:Double = 0
    var cash:Double = 0
    
    var newNum = false
    var equate = false
    var stack = false
    
    var currentOperator = ""
    var err = ""
    
    @IBOutlet var displayLabel: UILabel!
    
    // Numbers
    @IBAction func button0(_ sender: Any, forEvent event: UIEvent) {
        numPressed(num: "0")
    }
    @IBAction func button1(_ sender: Any, forEvent event: UIEvent) {
        numPressed(num: "1")
    }
    @IBAction func button2(_ sender: Any, forEvent event: UIEvent) {
        numPressed(num: "2")
    }
    @IBAction func button3(_ sender: Any, forEvent event: UIEvent) {
        numPressed(num: "3")
    }
    @IBAction func button4(_ sender: Any, forEvent event: UIEvent) {
        numPressed(num: "4")
    }
    @IBAction func button5(_ sender: Any, forEvent event: UIEvent) {
        numPressed(num: "5")
    }
    @IBAction func button6(_ sender: Any, forEvent event: UIEvent) {
        numPressed(num: "6")
    }
    @IBAction func button7(_ sender: Any, forEvent event: UIEvent) {
        numPressed(num: "7")
    }
    @IBAction func button8(_ sender: Any, forEvent event: UIEvent) {
        numPressed(num: "8")
    }
    @IBAction func button9(_ sender: Any, forEvent event: UIEvent) {
        numPressed(num: "9")
    }
    
    // operatorHandler and Other
    @IBAction func buttonPlus(_ sender: Any, forEvent event: UIEvent) {
        operatorHandler(op: "+")
    }
    @IBAction func buttonMinus(_ sender: Any, forEvent event: UIEvent) {
        operatorHandler(op: "-")
    }
    @IBAction func buttonMultiply(_ sender: Any, forEvent event: UIEvent) {
        operatorHandler(op: "x")
    }
    @IBAction func buttonDivide(_ sender: Any, forEvent event: UIEvent) {
        operatorHandler(op: "/")
    }
    @IBAction func buttonEquals(_ sender: Any, forEvent event: UIEvent) {
        operatorHandler(op: "=")
    }
    @IBAction func buttonReset(_ sender: Any, forEvent event: UIEvent) {
        resetOut()
    }
    @IBAction func buttonNeg(_ sender: Any, forEvent event: UIEvent) {
        currentNum = Double(displayLabel.text!)! * -1
        displayLabel.text = String(currentNum)
        currentTotal = Double(displayLabel.text!)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func operatorHandler(op: String) {
        if (equate || currentOperator == "="){
            if (currentOperator == "/" && currentTotal == 0) {
                displayLabel.text = "Division by 0"
                currentNum = 0
                currentTotal = 0
                currentOperator = ""
                equate = false
                newNum = false
            } else {
                if ((op == "x" || op == "/") && (currentOperator == "+" || currentOperator == "-")) {
                    equate = false
                    cash = currentNum
                    stack = true
                } else if (stack) {
                    stack = false
                    if (op == "x" || op == "/") {
                        stack = true
                    }
                    stackHandler()
                } else {equalsHandler()}
            }
            equate = false
            currentNum = currentTotal
        } else {
            currentNum = currentTotal
        }
        newNum = true
        currentOperator = op
    }
    
    func equalsHandler() {
        if (currentOperator == "+") {
            overflowCheck()
            currentTotal = currentNum + currentTotal
        } else if (currentOperator == "-") {
            overflowCheck()
            currentTotal = currentNum - currentTotal
        } else if (currentOperator == "x") {
            overflowCheck()
            currentTotal = currentNum * currentTotal
        } else if (currentOperator == "/") {
            currentTotal = currentNum / currentTotal
        }
        displayLabel.text = String(currentTotal)
    }
    
    func stackHandler() {
        if (currentOperator == "x") {
            overflowCheck()
            currentTotal = currentNum * currentTotal
        } else if (currentOperator == "/") {
            currentTotal = currentNum / currentTotal
        }
        if (!stack) {
            currentTotal = currentTotal + cash
        }
        displayLabel.text = String(currentTotal)
    }
    
    func overflowCheck() {
        err = ""
        if (currentOperator == "+") {
        err = currentTotal + currentNum > 2147483647 ? "Max Limit" :
            currentTotal + currentNum < -2147483648 ? "Min Limit" : ""
        } else if (currentOperator == "-") {
        err = currentTotal - currentNum > 2147483647 ? "Max Limit" :
            currentTotal - currentNum < -2147483648 ? "Min Limit" : ""
        } else if (currentOperator == "x") {
        err = currentTotal * currentNum > 2147483647 ? "Max Limit" :
            currentTotal * currentNum < -2147483648 ? "Min Limit" : ""
        }
        if (err != "") {
            print(err)
            resetOut()
        }
    }
    
    func numPressed(num: String) {
        if (newNum) {
            newNum = false
            currentTotal = 0
            if (currentOperator == "=") {
                currentNum = 0
            } else {
                equate = true
            }
        }
        if ((currentTotal >= 0 && (currentTotal * 10 + Double(num)!) <= 2147483647) ||
            (currentTotal < 0 && (currentTotal * 10 - Double(num)!) >= -2147483648)) {
            if (currentTotal >= 0) {
                currentTotal = (currentTotal * 10) + Double(num)!
            } else {
                currentTotal = (currentTotal * 10) - Double(num)!
            }
        } else {
            err = currentTotal > 0 ? "Max Limit" : "Min Limit"
            if (err != "") {
                print(err)
                resetOut()
            }
        }
        displayLabel.text = String(currentTotal)
    }
    
    func resetOut() {
        displayLabel.text = "0"
        newNum = true
        equate = false
        currentTotal = 0
        currentNum = 0
        currentOperator = ""
    }
}
