//
//  ViewController.swift
//  MapKitClass
//
//  Created by Lia Kassardjian on 06/04/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var points = [CLLocationCoordinate2D]()
    
    var locationManagerDelegate: LocationManagerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocationManager()
        mapView.showsUserLocation = !mapView.isUserLocationVisible
    }
    
    private func setLocationManager() {
        locationManagerDelegate = LocationManagerDelegate(vC: self)
        locationManagerDelegate?.setUp()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position: CGPoint = touch.location(in: view)
            let coord = mapView.convert(position, toCoordinateFrom: self.view)
            points.append(coord)
            
            mapView.removeAnnotations(mapView.annotations)
            
            let ann = MKPointAnnotation()
            ann.coordinate = coord
            ann.title = "Meu Pin"
            mapView.addAnnotation(ann)
            
        }
    }
    
    
}

