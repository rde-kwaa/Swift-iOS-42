//
//  ViewController.swift
//  Siri
//
//  Created by Ryan de Kwaadsteniet on 10/17/19.
//  Copyright © 2019 Ryan de Kwaadsteniet. All rights reserved.
//

import UIKit
import RecastAI

class ViewController: UIViewController, UITextFieldDelegate {

    var bot : RecastAIClient?
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func requestButton(_ sender: Any) {
        self.requestCheck()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.textField.delegate = self
        self.bot = RecastAIClient(token : "02a3762843bb1f515e9f11bcd2ba5d3a", language: "en")
    }
    
    func requestCheck() {
        print (textField.text as Any)
        if (textField.text != nil && textField.text != "") {
            self.doRequest(request: textField.text!)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.requestCheck()
        return true
    }
    
    func doRequest(request: String) {
            self.bot?.textRequest(request, successHandler: { (response) in
            let location = response.get(entity: "location")
                print("location", location ?? "none")
            if (location != nil) {
                let lat = location!["lat"]?.doubleValue
                let lng = location!["lng"]?.doubleValue
                print("lat", lat as Any, "lng", lng as Any)
                if (lat != nil) {
                    //self.makeWeatherRequest(lat: lat!, lng: lng!)
                } else {
                    self.label.text = "Error with Recast API try again"
                }
            } else {
                self.label.text = "Enter a valid city"
            }
            
        }, failureHandle: { (error) in
            print("error", error)
            self.label.text = "Error with Recast call"
        })
    }

}

