//
//  APITwitterDelegate.swift
//  Tweet
//
//  Created by Ryan DE KWAADSTENIET on 2019/10/11.
//  Copyright © 2019 Ryan DE KWAADSTENIET. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: AnyObject {
    init()
    
    func ear(tweet: [Tweet])
    func exception(err: NSError)
}

extension APITwitterDelegate {
    init() {
        self.init()
    }
}
