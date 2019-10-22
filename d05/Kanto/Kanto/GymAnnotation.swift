//
//  GymAnnotation.swift
//  Kanto
//
//  Created by Ryan de Kwaadsteniet on 10/15/19.
//  Copyright © 2019 Ryan de Kwaadsteniet. All rights reserved.
//

import UIKit
import MapKit

class GymAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var type: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, type: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.type = type
        
        super.init()
    }

}
