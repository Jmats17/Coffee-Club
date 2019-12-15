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

struct YelpAPIService {
    
    static func retrieveCafes(latitude : Double, longitude : Double, radius : Int, completion : @escaping ([Cafe]) -> Void) {
        
        let headers = ["Authorization" : "Bearer vlPagxO5hd5X2_VrVtHang0fwtpD0Od9leliYvwXp1bbYbzldgPnmqqRmkG6SJsn_0iQE6xqiNf7BNQG8BuhsUSjMrUcO7drgYvAG_G-SiQBKzmO6cINqQMh7jDoXXYx"]
        
        Alamofire.request(Constants.API.placeURL + "radius=\(radius)&latitude=\(latitude)&longitude=\(longitude)", method: .get, headers: headers).responseData { (response) in
            guard let data = response.result.value else { return completion([]) }
            var cafes = [Cafe]()
            let cafeArr = JSON(data)["businesses"].arrayValue
            for cafe in cafeArr {
                cafes.append(Cafe(json: cafe))
            }
            completion(cafes)
        }
    }
}
