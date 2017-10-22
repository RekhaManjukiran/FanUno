//
//  Network.swift
//  FanUno
//
//  Created by Rekha Manju Kiran on 17/10/2017.
//  Copyright © 2017 Rekha Manju Kiran. All rights reserved.
//

import UIKit
import Alamofire

typealias PlayerCompletionHandler = (_ success: Bool, _ player: [Player]?) -> Void

class Network {
    
    var playersJSON: [String: Any] = [:]
    var player = [Player]()
    let url = "https://cdn.rawgit.com/liamjdouglas/bb40ee8721f1a9313c22c6ea0851a105/raw/6b6fc89d55ebe4d9b05c1469349af33651d7e7f1/Player.json"
    
    func retrievePlayersJSON(completionHandler: @escaping PlayerCompletionHandler) {
        Alamofire.request(url).responseJSON { response in
            if let json = response.result.value as? [String: Any] {
                var success = false
                if let players = json["players"] as? [[String: Any]] {
                    success = true
                    self.player = Player.parseJsonObject(json: players)
                }
                else{
                    self.player = [Player]()
                }
                completionHandler(success, self.player)
            }
            
        }
    }
}

class DefaultImage {
    var url: String
    
    init() {
        url = ""
    }
    
    init(url: String) {
        self.url = url
    }
}




