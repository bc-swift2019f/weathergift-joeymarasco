//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Joseph Marasco on 10/17/19.
//  Copyright © 2019 Joseph Marasco. All rights reserved.
//

import Foundation
import Alamofire

// MARK:- APP WIDE SCOPE
class WeatherLocation {
    var name = ""
    var coordinates = ""
    
    func getWeather() {
        let weatherURL = urlBase + urlAPIKey + coordinates
        print(weatherURL)
        
        Alamofire.request(weatherURL).responseJSON { response in
            print(response)
        }
        
    }
}
