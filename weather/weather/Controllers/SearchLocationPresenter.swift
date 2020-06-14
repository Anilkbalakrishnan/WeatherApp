//
//  SearchLocationPresenter.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 13/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import Foundation


class SearchLocationPresenter {
    
    private let weatherService: WeatherServiceInterface
    weak private var viewDelegate: SearchViewControllerDelegate?
    
    init(weatherService: WeatherServiceInterface){
        self.weatherService = weatherService
        self.weatherService.setDataDelegate(delegate: self)
    }
    
    func setViewDelegate(viewDelegate: SearchViewControllerDelegate){
        self.viewDelegate = viewDelegate
    }
    
    func getLocationByName(name: String) {
        if !name.isEmpty {
            self.weatherService.searchLocationByName(searchText: name)
        }
        
    }
}

//MARK:- Weather service Data delegate
extension SearchLocationPresenter: WeatherServiceDataDelegate {
    
    func onSearchLocationFetchDidSucceed(searchLocationResponse: SearchLocationResponse) {
        let places = searchLocationResponse.embedded.location.map { $0.toPlacViewModel}
        DispatchQueue.main.async {
            self.viewDelegate?.onSearchDataFetchDidSucceed(places: places)
        }
        
    }
    
    func onSearchLocationFethcDidFailed() {
        
    }
    
    func onWeatherForcastFetchDidSucceed(weatherForcastResponse: WeatherForcastResponse) {
        
    }
    
    func onWeatherForcastFetchDidFiled() {
        
    }
    
    
}
