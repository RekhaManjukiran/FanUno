//
//  PlayerItem.swift
//  FanUno
//
//  Created by Rekha Manju Kiran on 18/10/2017.
//  Copyright © 2017 Rekha Manju Kiran. All rights reserved.
//

import UIKit

class Player {
    
    var firstName: String
    var lastName: String
    var fppg: Double
    var imageUrl: [DefaultImage]
    
    init() {
        firstName = ""
        lastName = ""
        fppg = 0.0
        imageUrl = []
    }
    
    init(firstName: String,
         lastName: String,
         fppg: Double,
         imageUrl: [DefaultImage]) {
        self.firstName = firstName
        self.lastName = lastName
        self.fppg = Double(round(fppg*10000)/10000) // Four digit rounding off
        self.imageUrl = imageUrl
    }
    
}
