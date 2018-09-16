//
//  ViewController.swift
//  Weather
//
//  Created by HeinHtet on 9/14/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit
import CoreLocation
import KYDrawerController


class WeatherVC: UIViewController {
    @IBAction func openDrawer(_ sender: Any) {
        if let drawer = self.parent as? KYDrawerController{
            drawer.setDrawerState(.opened, animated: true)
        }
    }
    
    @IBOutlet weak var countryLb: UILabel!
    @IBOutlet weak var temLb: UILabel!
    @IBOutlet weak var descriptionLb: UILabel!
    @IBOutlet weak var iv : UIImageView!
    @IBOutlet weak var collectionView : UICollectionView!
    

    var weather : Weather?
    var weatherList = [Weather.List]()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        collectionView.dataSource = self
        collectionView.delegate = self
        Utils.instance.getBgIcon()
        if let drawer = self.parent as? KYDrawerController{
            drawer.drawerWidth = self.view.frame.width / 1.5
        }
    }
}

extension WeatherVC : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell{
            cell.updateView(weather: weatherList[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherList.count
    }
    
}


extension WeatherVC : CLLocationManagerDelegate{
    
    
    
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
        print("location  latitude \(locations[0].coordinate.latitude) longgitude \(locations[0].coordinate.longitude)")
        locationManager.stopUpdatingLocation()
        Api.instance.request(lat : locations[0].coordinate.latitude,lon : locations[0].coordinate.longitude,loading: { (loading) in
        }, error: { (error) in
                    
        }) { (response) in
            self.weather = response
            self.updateView(weather : response)
            self.weatherList = response.list
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func updateView(weather : Weather){
        self.countryLb.text = weather.city.name
         let temperature = "  \(Int(weather.list[0].temp.morn.rounded(.toNearestOrEven)))\u{00B0}"
        self.temLb.text = temperature
        self.iv.image = Utils.instance.getIconForTemperature(weatherId: weather.list[0].weather[0].id)
        self.descriptionLb.text = weather.list[0].weather[0].description
    }
}

