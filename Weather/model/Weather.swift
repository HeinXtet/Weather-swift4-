//
//  Weather.swift
//  Weather
//
//  Created by HeinHtet on 9/15/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation

struct Weather : Codable {
    var cod : String
    var city : City
    var list : [List]

struct List : Codable {
    var dt : Int
    var temp : Temperature
    var pressure : Double
    var humidity : Double
    var weather : [WeatherStatus]
    var speed : Double
    var deg : Int
    var clouds : Int
}
struct WeatherStatus : Codable {
        var id : Int
        var main : String
        var description : String
        var icon : String
}

struct City : Codable{
    var id : Int
    var name : String
    var coord : Coord
    var country : String
    var population : CInt
    
    
}



struct Temperature  : Codable{
    var day : Double
    var min : Double
    var max : Double
    var night : Double
    var eve : Double
    var morn : Double
}



struct Coord : Codable{
    var lat : Double
    var lon : Double
}
}
