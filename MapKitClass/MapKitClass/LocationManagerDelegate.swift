//
//  LocationDelegate.swift
//  UIMapKit
//
//  Created by Lia Kassardjian on 02/04/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import MapKit

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    
    weak var viewController: ViewController?
    
    let locationManager = CLLocationManager()
    var coordinates: CLLocationCoordinate2D
    
    init(vC: ViewController) {
        self.viewController = vC
        coordinates = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
    public func setUp() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            coordinates = location.coordinate
            
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            viewController?.mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
}
