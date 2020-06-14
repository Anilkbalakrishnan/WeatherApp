//
//  WeatherForcastViewModel.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 14/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import Foundation

struct WeatherForcastViewModel {
    let weatherForcast: WeatherForcast
}

struct WeatherForcast {
    let forcasts: [Forcast]
}

struct Forcast {
    let forcastSummary: ForcastSummary
    let weatherPrediction: [WeatherInfo]
}

struct WeatherInfo {
    let temperature: String
    let time: String
    let iconName: String
}

struct ForcastSummary {
    let day: String
    let date: String
    let dayWeatherIcon: String
    let maxTemp: String
    let minTemp: String
    let currentTemp: String
}
