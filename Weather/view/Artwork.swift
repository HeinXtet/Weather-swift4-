//
//  Artwork.swift
//  Weather
//
//  Created by HeinHtet on 9/16/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//
import MapKit
import Foundation

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
