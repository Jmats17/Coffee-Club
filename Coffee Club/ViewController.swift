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
import JTMaterialTransition
class ViewController: UIViewController {

    var locationManager = CLLocationManager()
    var currentLocation : CLLocation?
    @IBOutlet var tableView : UITableView!
    var activityIndicator = UIActivityIndicatorView()
    var cafes = [Cafe]()
    var transition: JTMaterialTransition?
    @IBOutlet var profileButton : UIButton!
    var cafe : Cafe?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadIndicator()
        self.transition = JTMaterialTransition(animatedView: self.profileButton)
        tableView.separatorStyle = .none
        updateCafesAndLocation()
    }
    
    func didPresentControllerButtonTouch () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileViewController
        
        profileVC.modalPresentationStyle = .custom
        profileVC.transitioningDelegate = self.transition
        
        self.present(profileVC, animated: true, completion: nil)
    }
    
    func loadIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0))
        activityIndicator.style = .large
        activityIndicator.color = .gray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
    }
    
    @IBAction func presentProfileView(sender : UIButton) {
        didPresentControllerButtonTouch()
    }
    
    private func updateCafesAndLocation() {
        if let location = locationManager.location {
            YelpAPIService.retrieveCafes(latitude: Double(location.coordinate.latitude), longitude: Double(location.coordinate.longitude), radius: 2000) { (cafes) in
                self.cafes = cafes
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
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
        return 139
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafes.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCafeView" {
            let cafeVC = segue.destination as? CafeViewController
            cafeVC?.cafe = self.cafe
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cafe = cafes[indexPath.row]
        self.performSegue(withIdentifier: "toCafeView", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cafeCell = tableView.dequeueReusableCell(withIdentifier: "CafeCell", for: indexPath) as! CafeTableViewCell
        let cafe = cafes[indexPath.row]
        cafeCell.configureCell(cafe)
        return cafeCell
    }

}
