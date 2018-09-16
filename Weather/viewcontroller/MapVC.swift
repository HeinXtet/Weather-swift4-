//
//  MapVC.swift
//  Weather
//
//  Created by HeinHtet on 9/16/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let regionRaidus = 1000 as Double

    let locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self
        doubleTap()
    }
    
    private func doubleTap(){
        
        let singletap = UITapGestureRecognizer(target: self, action: #selector(animateDown))
        singletap.numberOfTapsRequired = 1
        self.mapView.addGestureRecognizer(singletap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin))
        doubleTap.numberOfTapsRequired = 2
        self.mapView.addGestureRecognizer(doubleTap)
        singletap.require(toFail: doubleTap)
        
    }
    
    private func removePin(){
        for annotation in mapView.annotations{
            mapView.removeAnnotation(annotation)
        }
    }
    
    @objc func dropPin(_ sender : UITapGestureRecognizer){
        removePin()

        let touchPoint = sender.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let region = MKCoordinateRegionMakeWithDistance(coordinate, regionRaidus * 2.0, regionRaidus * 2.0)
        mapView.setRegion(region, animated : true)
    
        let artwork = Artwork(title: "",
                              locationName: "Waikiki Gateway Park",
                              discipline: "Sculpture",
                              coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude:coordinate.longitude))
        mapView.addAnnotation(artwork)
        getPlace(coordinate: coordinate)
    }
    
    @objc func animateDown(){
       // print("animate down ")
    }
    
    func getPlace(coordinate : CLLocationCoordinate2D)  {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Address dictionary
            print(placeMark.addressDictionary)
            
            // Location name
            if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                print(locationName)
            }
            
            // Street address
            if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                print(street)
            }
            
            // City
            if let city = placeMark.addressDictionary!["City"] as? NSString {
                print(city)
            }
            
            // Zip code
            if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                print(zip)
            }
            
            // Country
            if let country = placeMark.addressDictionary!["Country"] as? NSString {
                print(country)
            }
            
        })
    }
  
}



extension MapVC : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // If status has not yet been determied, ask for authorization
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            // If authorized when in use
            manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            // If always authorized
            manager.startUpdatingLocation()
            break
        case .restricted:
            // If restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            print("user denied")
            // If user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        centerMapLocation(location: locations[0])
    }
    
}

extension MapVC : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    
    
    // focus and centering user location
    func centerMapLocation(location : CLLocation){
        let coordinate = location.coordinate
        let region = MKCoordinateRegionMakeWithDistance(coordinate, regionRaidus * 2.0, regionRaidus * 2.0)
        mapView.setRegion(region, animated : true)
    }
    
}

