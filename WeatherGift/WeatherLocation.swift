//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Joseph Marasco on 10/17/19.
//  Copyright © 2019 Joseph Marasco. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK:- APP WIDE SCOPE
class WeatherLocation {
    var name = ""
    var coordinates = " "
    var currentTemp = "--"
    var dailySummary = " "
    var currentIcon = " "
    var currentTime = 0.0
    var timeZone = ""
    
    func getWeather(completed: @escaping () -> ()) {
        let weatherURL = urlBase + urlAPIKey + coordinates
        
        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let temperature = json["currently"]["temperature"].double {
                    let roundedTemp = String(format: "%3.f", temperature)
                    self.currentTemp = roundedTemp + "°"
                } else {
                    print("Could not return temperature.")
                }
                if let summary = json["daily"]["summary"].string {
                    self.dailySummary = summary
                } else {
                    print("Could not return daily weather summary.")
                }
                if let icon = json["currently"]["icon"].string {
                    self.currentIcon = icon
                } else {
                    print("Could not return weather icon.")
                }
                if let timeZone = json["timezone"].string {
                    self.timeZone = timeZone
                } else {
                    print("Could not return a timezone.")
                }
                if let time = json["currently"]["time"].double {
                    self.currentTime = time
                } else {
                    print("Could not return a time.")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
