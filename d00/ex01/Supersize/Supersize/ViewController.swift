//
//  ViewController.swift
//  Supersize
//
//  Created by Ryan de Kwaadsteniet on 10/7/19.
//  Copyright © 2019 Ryan de Kwaadsteniet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    @IBAction func clickMe(_ sender: Any, forEvent event: UIEvent) {
        self.label.text = "FOOOO BAAAR"
        label.sizeToFit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label.sizeToFit()
    }

}

