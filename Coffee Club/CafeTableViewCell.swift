//
//  CafeTableViewCell.swift
//  Coffee Club
//
//  Created by Justin Matsnev on 12/15/19.
//  Copyright © 2019 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit
import KFSwiftImageLoader

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

    @IBOutlet var placeImgView : UIImageView! {
        didSet {
            placeImgView.layer.cornerRadius = 9.0
            placeImgView.layer.maskedCorners = [.layerMinXMinYCorner , .layerMinXMaxYCorner]
        }
    }
  
    func configureCell(_ cafe : Cafe) {
        nameLbl.text = cafe.name
        addressLbl.text = cafe.street + ", " + cafe.city + ", " + cafe.state + " " + cafe.zipCode
        phoneLbl.text = cafe.displayPhone
        configurePrice(cafe: cafe)
        loadImage(imgURL: cafe.img_URL)
    }
    
    private func loadImage(imgURL : String) {
        guard let url = URL(string: imgURL) else {return}
        DispatchQueue.main.async {
            self.placeImgView.loadImage(url: url)
        }
    }
    
    private func configurePrice(cafe : Cafe) {
        if cafe.priceLevel == "" {
            priceDistanceLbl.text = String(format: "%.2f", convertMetersToMiles(meters: cafe.distanceInMeters)) + " mi"
        } else {
            priceDistanceLbl.text = cafe.priceLevel + " - " + String(format: "%.2f", convertMetersToMiles(meters: cafe.distanceInMeters)) + " mi"
        }
    }
    
    private func convertMetersToMiles(meters : Double) -> Double {
        return meters * 0.00062137
    }
  
}
