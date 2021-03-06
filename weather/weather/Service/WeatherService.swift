//
//  WeatherService.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 13/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import Foundation
//MARK:- Protocol and Delegate
protocol WeatherServiceSearchDataDelegate: AnyObject {
    func onSearchLocationFetchDidSucceed(searchLocationResponse: SearchLocationResponse)
    func onSearchLocationFethcDidFailed()
}

protocol WeatherServiceForcastDataDelegate: AnyObject {
    func onWeatherForcastFetchDidSucceed(weatherForcastResponse: WeatherForcastResponse)
    func onWeatherForcastFetchDidFiled()
}

protocol WeatherServiceSearchInterface: AnyObject {
    func searchLocationByName(searchText: String)
    func setDataDelegate(delegate: WeatherServiceSearchDataDelegate)
}

protocol WeatherServiceForcastInterface: AnyObject {
    func getWeatherForcast(locationId: String)
    func setDataDelegate(delegate: WeatherServiceForcastDataDelegate)
}

//MARK:- WeatherService
class WeatherService: WeatherServiceSearchInterface, WeatherServiceForcastInterface {
    static let shared = WeatherService()
    
    weak private var searchDataDelegate: WeatherServiceSearchDataDelegate?
    weak private var forcastDataDelegate: WeatherServiceForcastDataDelegate?
    let baseUrl: String = WeatherApiConstant.baseUrl
    
    
    func searchLocationByName(searchText: String){
        let searchUrl = getSearchApiUrl(searchQuery: SearchQuery(searchText: searchText))
        NetworkManager.shared.HttpDataRequest(url: searchUrl, httpMethod: .GET, data: nil, completionHandler: { result in
            switch result {
            case .success(let searchData):
                if let searchResponse: SearchLocationResponse = searchData.decodeJSON(){
                    self.searchDataDelegate?.onSearchLocationFetchDidSucceed(searchLocationResponse: searchResponse)
                }
            case .failure(let error):
                 self.searchDataDelegate?.onSearchLocationFethcDidFailed()
            }
        });
    }
    
    func getWeatherForcast(locationId: String){
        let weatherForcastUrl = getWeatherForcastApiUrl(locatinId: locationId)
        NetworkManager.shared.HttpDataRequest(url: weatherForcastUrl, httpMethod: .GET, data: nil, completionHandler: { result in
            switch result {
            case .success(let weatherForcastData):
                if let forcastResponse: WeatherForcastResponse = weatherForcastData.decodeJSON(){
                    self.forcastDataDelegate?.onWeatherForcastFetchDidSucceed(weatherForcastResponse: forcastResponse)
                 }
            case .failure(let error):
                self.searchDataDelegate?.onSearchLocationFethcDidFailed()
            }
        });
    }
    
    func setDataDelegate(delegate: WeatherServiceSearchDataDelegate) {
        self.searchDataDelegate = delegate
    }
    
    func setDataDelegate(delegate: WeatherServiceForcastDataDelegate) {
        self.forcastDataDelegate = delegate
    }
}

extension WeatherService {
    
    private func getSearchApiUrl(searchQuery: SearchQuery) -> String {
        var searchApiUrl: String = baseUrl + WeatherApiConstant.searchPath
        if let searchText = searchQuery.searchText {
            searchApiUrl.append("q=\(searchText)&")
        }
        if let coordiantes = searchQuery.coordiante {
            searchApiUrl.append("lat=\(coordiantes.latitude)&lon=\(coordiantes.longitude)")
        }
        searchApiUrl.append("accuracy=\(searchQuery.accuracy)&language=\(searchQuery.language)")
        return searchApiUrl
    }
    
    private func getWeatherForcastApiUrl(locatinId: String) -> String {
        return baseUrl + "\(WeatherApiConstant.forcastPathPrefix)\(locatinId)\(WeatherApiConstant.forcastPathSuffix)"
    }
}

struct SearchQuery {
    let searchText: String?
    var accuracy: Int = 1000
    let language: String = "nn"
    var coordiante: GeoCoordinates?
    
    init(searchText: String?, coordiantes: GeoCoordinates? = nil){
        self.searchText = searchText
        self.coordiante = coordiantes
    }
}

struct GeoCoordinates {
    let latitude: Double
    let longitude: Double
}



