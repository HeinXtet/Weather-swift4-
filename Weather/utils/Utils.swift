//
//  Utils.swift
//  Weather
//
//  Created by HeinHtet on 9/15/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation
import UIKit
class Utils {
    static let instance = Utils()
    
    func dayDifference(from interval : TimeInterval) -> String
    {
        let calendar = NSCalendar.current
        let date = Date(timeIntervalSince1970: interval)
        if calendar.isDateInYesterday(date) { return "Yesterday" }
        else if calendar.isDateInToday(date) { return "Today" }
        else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
        else {
            let startOfNow = calendar.startOfDay(for: Date())
            let startOfTimeStamp = calendar.startOfDay(for: date)
            let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
            let day = components.day!
            if day < 1 { return "\(abs(day)) days ago" }
            else { return "In \(day) days" }
        }
    }
    func getReadableDate(timeStamp: TimeInterval) -> String? {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInTomorrow(date) {
            return "Tomorrow"
        } else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        } else if dateFallsInCurrentWeek(date: date) {
            if Calendar.current.isDateInToday(date) {
                return "Today"
                //dateFormatter.dateFormat = "h:mm a"
                //return dateFormatter.string(from: date)
            } else {
                dateFormatter.dateFormat = "EEEE"
                return dateFormatter.string(from: date)
            }
        } else {
//            dateFormatter.dateFormat = "MMM d, yyyy"
            dateFormatter.dateFormat = "EE"

            return dateFormatter.string(from: date)
        }
    }
    
    func dateFallsInCurrentWeek(date: Date) -> Bool {
        let currentWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: Date())
        let datesWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: date)
        return (currentWeek == datesWeek)
    }


    func getIconForTemperature(weatherId : Int) -> UIImage? {
        if (weatherId >= 200 && weatherId <= 232) {
            return UIImage(named: "weather-storm-day")
        } else if (weatherId >= 300 && weatherId <= 321) {
            return UIImage(named: "weather-showers-scattered-night")
        } else if (weatherId >= 500 && weatherId <= 504) {
            return UIImage(named: "weather-showers-scattered-day")
        } else if (weatherId == 511) {
            return UIImage(named: "weather-snow-scattered-day")
        } else if (weatherId >= 520 && weatherId <= 531) {
            return UIImage(named: "weather-showers-scattered-day")
        } else if (weatherId >= 600 && weatherId <= 622) {
            return UIImage(named: "weather-snow-scattered-day")
        } else if (weatherId >= 701 && weatherId <= 761) {
            return UIImage(named: "weather-fog")
        } else if (weatherId == 761 || weatherId == 781) {
            return UIImage(named: "weather-storm-day")
        } else if (weatherId == 800) {
            return UIImage(named: "weather-clear")
        } else if (weatherId == 801) {
            return UIImage(named: "weather-few-clouds")
        } else if (weatherId >= 802 && weatherId <= 804) {
            return UIImage(named: "weather-few-clouds")
        }
        return UIImage(named: "");
    }
    
    func getTempCelcius(temp : Double) -> String {
       return  "\(Int(temp.rounded(.toNearestOrEven)))\u{00B0}"
        
    }
    
    func CelcToFer(temperature : Double) -> String {
        var temp = temperature
        temp = (temp * 1.8) + 32
        return ""
        
    }

    
    func getBgIcon() {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12 : print(NSLocalizedString("Morning", comment: "Morning"))
        case 12 : print(NSLocalizedString("Noon", comment: "Noon"))
        case 13..<17 : print(NSLocalizedString("Afternoon", comment: "Afternoon"))
        case 17..<22 : print(NSLocalizedString("Evening", comment: "Evening"))
        default: print(NSLocalizedString("Night", comment: "Night"))
        }
    }
}
