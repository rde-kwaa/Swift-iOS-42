//
//  TableViewController.swift
//  TableView
//
//  Created by Ryan de Kwaadsteniet on 10/9/19.
//  Copyright © 2019 Ryan de Kwaadsteniet. All rights reserved.
//

import Foundation
import UIKit

struct CellData {
    let name: String?
    let description: String?
    let date: String?
}

class TableViewController: UITableViewController {
    
    var data = [CellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        data = [CellData(name: "Hamlet", description: "Just Dies", date: "12 . 10 . 2019"),
                CellData(name: "Bamlet", description: "Goes out with a bam", date: "13 . 10 . 2019"),
                CellData(name: "Jamjamlet", description: "Death by Jam", date: "14 . 10 . 2019")]
        
        self.tableView.register(deathCell.self, forCellReuseIdentifier: "deathCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let deathCell = self.tableView.dequeueReusableCell(withIdentifier: "deathCell", for: indexPath) as! deathCell
        deathCell.name = data[indexPath.row].name
        deathCell.deth = data[indexPath.row].description
        deathCell.date = data[indexPath.row].date
        
        return deathCell
    }

}

