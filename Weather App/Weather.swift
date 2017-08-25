//
//  Weather.swift
//  Weather App
//
//  Created by wan muzaffar Wan Hashim on 25/08/2017.
//  Copyright © 2017 iTrain Asia Pte Ltd. All rights reserved.
//

import UIKit

class Weather: NSObject {
    
    var iconId : String
    var weather: String
    var weatherDesc: String
    var temp : Int
    var humidity : Int
    var pressure : Double
    var date : String
    
     init(iconId : String, weather: String, weatherDesc : String, temp: Int, humidity: Int, pressure: Double, date: String) {
        self.iconId = iconId
        self.weather = weather
        self.weatherDesc = weatherDesc
        self.temp = temp
        self.humidity = humidity
        self.pressure = pressure
        self.date = date
        
    }
    

}
