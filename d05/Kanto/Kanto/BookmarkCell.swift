//
//  BookmarkCell.swift
//  Kanto
//
//  Created by Ryan de Kwaadsteniet on 10/15/19.
//  Copyright © 2019 Ryan de Kwaadsteniet. All rights reserved.
//

import Foundation
import UIKit

class BookmarkCell: UITableViewCell {
        
    var location : (Double, Double, String, String)? {
        didSet {
            if let label = location {
                self.textLabel?.text = label.2
                self.detailTextLabel?.text = label.3
            }
        }
    }
}
