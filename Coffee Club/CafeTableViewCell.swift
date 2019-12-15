//
//  CafeTableViewCell.swift
//  Coffee Club
//
//  Created by Justin Matsnev on 12/15/19.
//  Copyright © 2019 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit

class CafeTableViewCell : UITableViewCell {
    
    @IBOutlet var mainContentView : UIView! {
        didSet {
            mainContentView.layer.cornerRadius = 7.0
        }
    }
    @IBOutlet var subContentView : UIView! {
        didSet {
            subContentView.layer.cornerRadius = 3.0
        }
    }
    
    @IBOutlet var nameLbl : UILabel!
    @IBOutlet var addressLbl : UILabel!
    @IBOutlet var phoneLbl : UILabel!
    @IBOutlet var priceDistanceLbl : UILabel!

    @IBOutlet var placeImgView : UIImageView!

    func configureCell(_ cafe : Cafe) {
        nameLbl.text = cafe.name
        addressLbl.text = cafe.street + ", " + cafe.city + ", " + cafe.state + " " + cafe.zipCode
        phoneLbl.text = cafe.displayPhone
        priceDistanceLbl.text = cafe.priceLevel + String(format: "$.2f", convertMetersToMiles(meters: cafe.distanceInMeters)) + " mi"
    }
    
    private func convertMetersToMiles(meters : Double) -> Double {
        return meters * 0.00062137
    }
  
}
