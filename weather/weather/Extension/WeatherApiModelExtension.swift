//
//  WeatherApiModelExtension.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 13/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import Foundation
extension Location {
    var toPlacViewModel: PlaceViewModel {
        return PlaceViewModel(id: self.id, name: self.name, region: self.region?.name ?? "", category: self.category.name, subRegion: self.subregion?.name ?? "", country: self.country?.name ?? "", currentTemperature: 21, weatherIconName: "02d")
    }
}


extension WeatherForcastResponse {
    func toWeatherForcastViewModel() -> WeatherForcastViewModel {
        let forcastGroupedByDate = Dictionary(grouping: self.shortIntervals) { $0.start.getDate }
        var forcasts = [Forcast]()
        for (date, intervals) in forcastGroupedByDate {
            let forcast = Forcast(day: date, date: date, dayWeatherIcon: "02d", maxTemp: "21°", minTemp: "22°", currentTemp: "22°", weatherPrediction: intervals.map{$0.toWeatherInfo})
            forcasts.append(forcast)
        }
        
        return WeatherForcastViewModel(weatherForcast: WeatherForcast(forcasts: forcasts))
    }
}


extension ShortInterval {
    var toWeatherInfo: WeatherInfo {
        return WeatherInfo(temperature: String(Int(self.temperature.value ?? 0)) + "°" , time: self.start.getTime, iconName: "02d")
    }
}

extension Date {
    var getTime: String {
        let df = DateFormatter()
        df.dateFormat = "hh:mm"
        return df.string(from:self)
    }
    
    var getDate: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: self)
    }
}


