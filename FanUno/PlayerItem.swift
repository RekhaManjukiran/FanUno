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
    
    class func parseJsonObject(json:[[String: Any]]) -> [Player] {
        
        var players = [Player]()        
        for player in json {

            var playerObject = Player()
            if let firstName = player["first_name"] as? String {
                playerObject.firstName = firstName
            }
            if let fppg = player["fppg"] as? Double {
                playerObject.fppg = Double(round(fppg * 10000)/10000) // 4 digit round-off
            }
            if let images = player["images"] as? [String: Any] {
                if let defaulImage = images["default"] as? [String: Any] {
                    let imageUrl = DefaultImage()
                    if let url = defaulImage["url"] as? String {
                        imageUrl.url = url
                        playerObject.imageUrl.append(imageUrl)
                        
                    }}
            }
            players.append(playerObject)
        }
        return players
    }
    
}
