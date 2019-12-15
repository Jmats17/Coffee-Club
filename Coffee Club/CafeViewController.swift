//
//  CafeViewController.swift
//  Coffee Club
//
//  Created by Justin Matsnev on 12/15/19.
//  Copyright © 2019 Justin Matsnev. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class CafeViewController : UIViewController {
    
    @IBOutlet var mapView : MKMapView! {
        didSet {
            mapView.layer.cornerRadius = 7.0
            mapView.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
        }
    }
    @IBOutlet var nameLbl : UILabel!
    @IBOutlet var addressLbl : UILabel!
    @IBOutlet var numberLbl : UILabel!
    @IBOutlet var milesLbl : UILabel!
    @IBOutlet var priceLbl : UILabel!
    @IBOutlet var checkInButton : UIButton! {
        didSet {
            checkInButton.layer.cornerRadius = 7.0
        }
    }
    var cafe : Cafe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let cafe = cafe else {return}
        updateCafeUI(cafe: cafe)
        showCafeOnMap(cafe: cafe)
    }
    
    func updateCafeUI(cafe : Cafe) {
        nameLbl.text = cafe.name
        addressLbl.text = cafe.street + ", " + cafe.city + ", " + cafe.state + " " + cafe.zipCode
        numberLbl.text = cafe.displayPhone
        milesLbl.text = String(format: "%.2f", cafe.distanceInMeters * 0.00062137) + " miles away"
        priceLbl.text = cafe.priceLevel + " - \(cafe.rating)"
    }
    
    private func showCafeOnMap(cafe : Cafe) {
        let location = CLLocationCoordinate2D(latitude: cafe.latitude,
                                              longitude: cafe.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
            
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = cafe.name
        annotation.subtitle = "Rating: \(cafe.rating)"
        mapView.addAnnotation(annotation)
    }
}
