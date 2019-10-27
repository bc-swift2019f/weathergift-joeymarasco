//
//  HourlyWeatherCell.swift
//  WeatherGift
//
//  Created by Joseph Marasco on 10/27/19.
//  Copyright © 2019 Joseph Marasco. All rights reserved.
//

import UIKit

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "ha"
    return dateFormatter
}()

class HourlyWeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var hourlyTime: UILabel!
    @IBOutlet weak var hourlyTemp: UILabel!
    @IBOutlet weak var hourlyPrecipProb: UILabel!
    @IBOutlet weak var hourlyIcon: UIImageView!
    @IBOutlet weak var rainDropImage: UIImageView!
    
    func update(with hourlyForecast: WeatherLocation.HourlyForecast, timezone: String) {
        hourlyTemp.text = String(format: "%2.f", hourlyForecast.hourlyTemperature) + "°"
        hourlyIcon.image = UIImage(named: "small-" + hourlyForecast.hourlyIcon)
        let percipProb = hourlyForecast.hourlyPercipProb * 100
        let isHidden = percipProb < 30
        hourlyPrecipProb.isHidden = isHidden
        rainDropImage.isHidden = isHidden
        hourlyPrecipProb.text = String(format: "%2.f", percipProb) + "%"
        let dateString = hourlyForecast.hourlyTime.format(timeZone: timezone, dateFormatter: dateFormatter)
        hourlyTime.text = dateString
        
    }
    
}
