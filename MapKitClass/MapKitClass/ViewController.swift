//
//  ViewController.swift
//  MapKitClass
//
//  Created by Lia Kassardjian on 06/04/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var point: CLLocationCoordinate2D?
    var locationManagerDelegate: LocationManagerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocationManager()
        mapView.showsUserLocation = !mapView.isUserLocationVisible
        mapView.delegate = self
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position: CGPoint = touch.location(in: view)
            let coord = mapView.convert(position, toCoordinateFrom: self.view)
            point = coord
            
            mapView.removeAnnotations(mapView.annotations)
            
            let ann = MKPointAnnotation()
            ann.coordinate = coord
            ann.title = "Meu Pin"
            mapView.addAnnotation(ann)
            
            guard
                let source = locationManagerDelegate?.coordinates,
                let destination = point
                else { return }
            
            mapView.removeOverlays(mapView.overlays)
            requestDirectionsTo(source: source, destination: destination)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if let overlay = overlay as? MKPolyline {
            let poly = MKPolylineRenderer(overlay: overlay)
            poly.strokeColor = .blue
            poly.lineWidth = 3
            return poly
        }
        
        return MKCircleRenderer()
    }
    
    private func setLocationManager() {
        locationManagerDelegate = LocationManagerDelegate(vC: self)
        locationManagerDelegate?.setUp()
    }
    
    func requestDirectionsTo(source : CLLocationCoordinate2D, destination : CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            if error == nil {
                if let routes = response?.routes {
                    for route in routes {
                        print(route.distance)
                        self.mapView.addOverlays([route.polyline])
                    }
                }
            }
        }
    }
    
}

