//
//  Cafe.swift
//  Coffee Club
//
//  Created by Justin Matsnev on 11/18/19.
//  Copyright © 2019 Justin Matsnev. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Cafe {
    
    let latitude : Double
    let longitude : Double
    let icon : String
    let place_id : String
    let name : String
    let openNow : Bool
    let priceLevel : Int
    let rating : Double
    let types : [String]
    let address : String
    
    init(json : JSON) {
        latitude = json["geometry"]["location"]["lat"].doubleValue
        longitude = json["geometry"]["location"]["lng"].doubleValue
        icon = json["icon"].stringValue
        place_id = json["place_id"].stringValue
        name = json["name"].stringValue
        openNow = json["opening_hours"]["open_now"].boolValue
        priceLevel = json["price_level"].intValue
        rating = json["rating"].doubleValue
        types = json["types"].arrayObject as! [String]
        address = json["vicinity"].stringValue
    }
}
