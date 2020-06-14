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
            if let formattedDate = date.getFormattedDate {
                let weatherForcasts = intervals.map{$0.toWeatherInfo}
                let maxTemperature = weatherForcasts.map{$0.temperature}.max()?.toTemperateString ?? ""
                let minTemperature = weatherForcasts.map{$0.temperature}.min()?.toTemperateString ?? ""
                
                let forcast = Forcast(date: formattedDate.date, forcastSummary: ForcastSummary(day: formattedDate.day , date: formattedDate.dateString, weatherIcon: getWeatherIconForTheDay(forcasts: weatherForcasts), maxTemp: maxTemperature, minTemp: minTemperature , currentTemp: "22°"), weatherPrediction: weatherForcasts)
                forcasts.append(forcast)
            }
        }
        return WeatherForcastViewModel(weatherForcast: WeatherForcast(forcasts: forcasts.sorted(by: { (forcast1, forcast2) -> Bool in
            return forcast1.date < forcast2.date
        })))
    }
    
    private func getWeatherIconForTheDay(forcasts: [WeatherInfo]) -> String {
        let forcastGroupByWeatherIcon = Dictionary(grouping: forcasts) { $0.iconName }
        var iconOccurances = [IconOccurance]()
        for( icon, occurances) in forcastGroupByWeatherIcon {
            iconOccurances.append(IconOccurance(name: icon, count: occurances.count))
        }
        
       let iconsSortedbyOccurance =  iconOccurances.sorted { (occurance1, occurance2) -> Bool in
            occurance1.count > occurance2.count
        }
        return iconsSortedbyOccurance.first?.name ?? "02d"
    }
}


struct IconOccurance {
    let name: String
    let count: Int
}


extension ShortInterval {
    var toWeatherInfo: WeatherInfo {
        return WeatherInfo(temperature: Float(self.temperature.value ?? 0), time: self.start.getTime, iconName: self.symbol.getIconName)
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
            break
        }
        return iconName
    }
}



//MARK:- Date Extesnison
extension Date {
    var getTime: String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm"
        return dateFormater.string(from:self)
    }
    
    var getDate: String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        return dateFormater.string(from: self)
    }
}


extension String {
    var getFormattedDate: FormattedDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return nil }
        dateFormatter.locale = Locale(identifier: "nb")
        dateFormatter.setLocalizedDateFormatFromTemplate("dMMMM")
        let formattedDate = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "EEEE"
        let day = dateFormatter.string(from: date)
        return FormattedDate(dateString: formattedDate, day: day.capitalizingFirstLetter(), date: date)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    var appendDegree: String {
        return self + "°"
    }
    
}

extension Float {
    var toTemperateString: String {
        return String(Int(self)).appendDegree
    }
}

struct FormattedDate {
    let dateString: String
    let day: String
    let date: Date
    
}




