//
//  deathCell.swift
//  TableView
//
//  Created by Ryan de Kwaadsteniet on 10/9/19.
//  Copyright © 2019 Ryan de Kwaadsteniet. All rights reserved.
//

import Foundation
import UIKit

class deathCell: UITableViewCell {
    
    var name: String?
    var deth: String?
    var date: String?
    
    var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.white
        return label
    }()
    
    var deathLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Noteworthy-Light", size: 13)
        label.textColor = UIColor.red
        return label
    }()
    
    var dateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textColor = UIColor.white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(nameLabel)
        self.addSubview(deathLabel)
        self.addSubview(dateLabel)
        self.backgroundColor = UIColor.secondaryLabel
        
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10) .isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.deathLabel.topAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.dateLabel.leftAnchor).isActive = true
        
        deathLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        deathLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        deathLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        deathLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor).isActive = true
        
        dateLabel.leftAnchor.constraint(equalTo: self.nameLabel.rightAnchor).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.deathLabel.topAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let name = name {
            nameLabel.text = name
        }
        if let deth = deth {
            deathLabel.text = deth
        }
        if let date = date {
            dateLabel.text = date
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
