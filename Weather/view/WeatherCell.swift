//
//  WeatherCell.swift
//  Weather
//
//  Created by HeinHtet on 9/15/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var iv : UIImageView!
    @IBOutlet weak var dateLb : UILabel!
    @IBOutlet weak var temp : UILabel!
    
    
    func updateView(weather : Weather.List)  {
        self.iv.image = Utils.instance.getIconForTemperature(weatherId: weather.weather[0].id)
        self.dateLb.text = Utils.instance.getReadableDate(timeStamp: TimeInterval(weather.dt))
        self.temp.text = Utils.instance.getTempCelcius(temp : weather.temp.day)
    }
    
    
}
