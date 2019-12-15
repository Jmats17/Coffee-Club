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
    let img_URL : String
    let place_id : String
    let name : String
    let isClosed : Bool
    let priceLevel : String
    let rating : Double
    let street : String
    let city : String
    let zipCode : String
    let country : String
    let state : String
    let url : String
    let numReviews : Int
    let distanceInMeters : Double
    let displayPhone : String
    let phone : String
    
    init(json : JSON) {
        latitude = json["coordinates"]["latitude"].doubleValue
        longitude = json["coordinates"]["longitude"].doubleValue
        img_URL = json["image_url"].stringValue
        place_id = json["id"].stringValue
        name = json["name"].stringValue
        isClosed = json["is_closed"].boolValue
        priceLevel = json["price"].stringValue
        rating = json["rating"].doubleValue
        street = json["location"]["address1"].stringValue
        city = json["location"]["city"].stringValue
        zipCode = json["location"]["zip_code"].stringValue
        country = json["location"]["country"].stringValue
        state = json["location"]["state"].stringValue
        url = json["url"].stringValue
        numReviews = json["review_count"].intValue
        distanceInMeters = json["distance"].doubleValue
        displayPhone = json["display_phone"].stringValue
        phone = json["phone"].stringValue

    }
}
