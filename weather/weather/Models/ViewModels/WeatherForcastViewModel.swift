//
//  WeatherForcastViewModel.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 14/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import Foundation
import UIKit

struct WeatherForcastViewModel {
    let weatherForcast: WeatherForcast
}

struct WeatherForcast {
    let forcasts: [Forcast]
}

struct Forcast {
    let date: Date
    let forcastSummary: ForcastSummary
    let weatherPrediction: [WeatherInfo]
}

struct WeatherInfo {
    let temperature: Float
    let time: String
    let iconName: String
}

struct ForcastSummary {
    let day: String
    let date: String
    let weatherIcon: String
    let maxTemp: String
    let minTemp: String
    let currentTemp: String
    var weatherIconImage: UIImage? {
        return UIImage(named: self.weatherIcon)
    }
}


extension ForcastSummary {
    var temperatureRange: String {
        return self.minTemp + "/" + self.maxTemp
    }
}
