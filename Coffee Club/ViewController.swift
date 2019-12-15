//
//  ViewController.swift
//  Coffee Club
//
//  Created by Justin Matsnev on 11/18/19.
//  Copyright © 2019 Justin Matsnev. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class ViewController: UIViewController {

    var locationManager = CLLocationManager()
    var currentLocation : CLLocation?
    @IBOutlet var tableView : UITableView!
    var cafes = [Cafe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCafesAndLocation()
    }
    
    private func updateCafesAndLocation() {
        if let location = locationManager.location {
            YelpAPIService.retrieveCafes(latitude: Double(location.coordinate.latitude), longitude: Double(location.coordinate.longitude), radius: 2000) { (cafes) in
                self.cafes = cafes
                self.tableView.reloadData()
            }
        } else {
            retrieveUsersLocation()
        }
    }

    private func retrieveUsersLocation() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }

}

extension ViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cafeCell = tableView.dequeueReusableCell(withIdentifier: "CafeCell", for: indexPath) as! CafeTableViewCell
        let cafe = cafes[indexPath.row]
        cafeCell.configureCell(cafe)
        return cafeCell
    }

}
