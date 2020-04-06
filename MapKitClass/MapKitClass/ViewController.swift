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
    
    var locationManagerDelegate: LocationManagerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func setLocationManager() {
        locationManagerDelegate = LocationManagerDelegate(vC: self)
        locationManagerDelegate?.setUp()
    }


}

