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
            let forcast = Forcast(forcastSummary: ForcastSummary(day: date, date: date, dayWeatherIcon: "02d", maxTemp: "21°", minTemp: "22°", currentTemp: "22°"), weatherPrediction: intervals.map{$0.toWeatherInfo})
            forcasts.append(forcast)
        }
        
        return WeatherForcastViewModel(weatherForcast: WeatherForcast(forcasts: forcasts))
    }
}


extension ShortInterval {
    var toWeatherInfo: WeatherInfo {
        return WeatherInfo(temperature: String(Int(self.temperature.value ?? 0)) + "°" , time: self.start.getTime, iconName: self.symbol.getIconName)
    }
}

//MARK:- Symbol Extension

extension Symbol {
    var getIconName: String {
        var iconName = self.n > 9 ? String(self.n) : "0" + String(self.n)
        switch self.symbolVar {
        case "Moon":
            iconName = iconName + "n"
        case "Sun":
            iconName = iconName + "d"
//TODO:- Need to find what is the value for Polar night and add a case insetead of in deafult
        default:
            iconName + "m"
        }
        return iconName
    }
}



//MARK:- Date Extesnison
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


