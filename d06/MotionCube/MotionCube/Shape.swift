//
//  Shape.swift
//  MotionCube
//
//  Created by Ryan de Kwaadsteniet on 10/16/19.
//  Copyright © 2019 Ryan de Kwaadsteniet. All rights reserved.
//

import UIKit

class Shape: UIView {
    
    var type: String = "Square"
    var collisionType: UIDynamicItemCollisionBoundsType = .rectangle

    override init(frame: CGRect) {
        super.init(frame: frame)
        bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        switch(arc4random_uniform(7)) {
        case 0:
            backgroundColor = .black
        case 1:
            backgroundColor = .blue
        case 2:
            backgroundColor = .purple
        case 3:
            backgroundColor = .green
        case 4:
            backgroundColor = .brown
        case 5:
            backgroundColor = .cyan
        case 6:
            backgroundColor = .magenta
        default:
            backgroundColor = .red
        }
        if (arc4random_uniform(2) == 0) {
            type = "Circle"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Can use an override on the bounds property whenever its called also
    override var bounds: CGRect {
        get { return super.bounds }
        set(newBounds) {
            super.bounds = newBounds
            if (self.type == "Circle") {
                layer.cornerRadius = newBounds.size.width / 2.0
                self.collisionType = .ellipse
            }
        }
    }
}
