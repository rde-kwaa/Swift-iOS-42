//
//  FirstViewController.swift
//  Kanto
//
//  Created by Ryan de Kwaadsteniet on 10/14/19.
//  Copyright © 2019 Ryan de Kwaadsteniet. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func mapViewType(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        
        switch index {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        }
    }
    
    @IBAction func userLocation(_ sender: Any) {
        centerMapOnUserLocation()
    }
    
    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()
    // set initial location in 42 Scool, Paris
    let initialLocation = CLLocation(latitude: 48.8967, longitude: 2.3185)
    let anoLocation = CLLocationCoordinate2D(latitude: 48.8967, longitude: 2.3185)
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        addNewAnnotation(anno: GymAnnotation(coordinate: List.coord[0].coordinate, title: List.locations[0].2, subtitle: List.locations[0].3, type: List.locations[0].4))
        checkLocationServices()
        let tabbar = tabBarController as! BaseTabBarController
        index = tabbar.value
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tabbar = tabBarController as! BaseTabBarController
        index = tabbar.value
        print("index at viewDidAppear: \(String(describing: index))")
        if (index != -1) {
            centerMapOnLocation(location: List.coord[index!])
            addNewAnnotation(anno: GymAnnotation(coordinate: List.coord[index!].coordinate, title: List.locations[index!].2, subtitle: List.locations[index!].3, type: List.locations[index!].4))
        }
    }
    
    func addNewAnnotation(anno: GymAnnotation) {
        mapView.addAnnotation(anno)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            // setup location manager
            setupLocationManager()
            checkLocationAuthorisation()
        } else {
            // let user know to turn on location for app
        }
    }
    
    func checkLocationAuthorisation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // map stuff
            mapView.showsUserLocation = true
            centerMapOnLocation(location: initialLocation)
            break
        case .denied:
            // alert to tell them how to turn on location
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // another alert
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func centerMapOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
      mapView.setRegion(region, animated: true)
    }

}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorisation()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
            annotationView.animatesWhenAdded = true
            annotationView.titleVisibility = .adaptive
            if annotation.title == "My Location" {
                annotationView.markerTintColor = .magenta
            } else if annotation.title == "WeThinkCode_" {
                annotationView.markerTintColor = .blue
            } else if annotation.title == "42 Silicon Valley" {
                annotationView.markerTintColor = .green
            }
            
            return annotationView
        }
        return nil
    }
}
