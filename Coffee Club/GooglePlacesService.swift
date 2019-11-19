//
//  GooglePlacesService.swift
//  Coffee Club
//
//  Created by Justin Matsnev on 11/18/19.
//  Copyright © 2019 Justin Matsnev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct GooglePlacesService {
    
    static func retrieveCafes(latitude : Double, longitude : Double, radius : Double, completion : @escaping ([Cafe]) -> Void) {
        Alamofire.request(Constants.API.placeURL + Constants.API.nearbySearch + "?location=\(latitude),\(longitude)&radius=\(radius)&type=cafe&keyword=coffee&key=" + Constants.API.key).responseData { (response) in
            guard let data = response.result.value else { return completion([]) }
            var cafes = [Cafe]()
            let cafeArr = JSON(data)["results"].arrayValue
            for cafe in cafeArr {
                cafes.append(Cafe(json: cafe))
            }
            completion(cafes)
        }
    }
}
