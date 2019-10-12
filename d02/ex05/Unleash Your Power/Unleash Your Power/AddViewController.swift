//
//  AddViewController.swift
//  Death Note Add
//
//  Created by Ryan de Kwaadsteniet on 10/10/19.
//  Copyright © 2019 Ryan de Kwaadsteniet. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextViewDelegate {

    var deathData: ((CellData) -> ())?
    let format = DateFormatter()
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var text: UITextView!
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        let s = name.text!
        if (s == "Name" || s == "")
        {
            print("No name given")
        } else {
            format.dateFormat = "dd . MM . yyy HH:mm:ss"
            deathData?(CellData(name: s, description: text.text, date: format.string(from: date.date)))
        }
        
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if text.textColor == UIColor.lightGray {
            text.text = nil
            text.textColor = UIColor.red
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if text.text.isEmpty {
            text.text = "How must they die..."
            text.textColor = UIColor.lightGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        date.minimumDate = Date()
        text.delegate = self
        text.text = "How must they die..."
        text.textColor = UIColor.lightGray
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
