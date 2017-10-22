////
////  PlayerItems.swift
////  FanUno
////
////  Created by Rekha Manju Kiran on 17/10/2017.
////  Copyright © 2017 Rekha Manju Kiran. All rights reserved.
////
//
//import UIKit
//import ObjectMapper
//
//class PlayerItems: Mappable {
//
//    var object: [Players] = []
//
//    required init?(map: Map) {
//        
//    }
//    
//    func mapping(map: Map) {
//        object <- map["object"]
//    }
//}
//
//class Players: Mappable {
//    var players: [PlayerItem] = []
//    
//    required init?(map: Map) {
//        
//    }
//    
//    func mapping(map: Map) {
//        players <- map["players"]
//    }
//}
//
//class PlayerItem: Mappable {
//    var firstName: String = ""
//    var fppg: Int = 0
//    var image: [PlayerImage] = []
//    
//    required init?(map: Map) {
//        
//    }
//    
//    func mapping(map: Map) {
//        firstName <- map["first_name"]
//        fppg <- map["fppg"]
//        image <- map["images"]
//    }
//}
//
//class PlayerImage: Mappable {
//    var defaultImage: [DefaultImage] = []
//    
//    required init?(map: Map) {
//        
//    }
//    
//    func mapping(map: Map) {
//        defaultImage <- map["default"]
//    }
//}
//
//class DefaultImage: PlayerImage {
//    var url: String = ""
//    
//    override func mapping(map: Map) {
//        url <- map["url"]
//    }
//}
