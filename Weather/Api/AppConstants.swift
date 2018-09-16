//
//  AppConstants.swift
//  Weather
//
//  Created by HeinHtet on 9/14/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation
typealias loading = (_ loading:Bool)->()
typealias error = (_ error:Error?)->()
typealias success = (_ success : Weather)->()
let url = "http://api.openweathermap.org/data/2.5/forecast/daily?units=metric&cnt=5&appid=e5595d5016d39a34458c6c67d6974696"



