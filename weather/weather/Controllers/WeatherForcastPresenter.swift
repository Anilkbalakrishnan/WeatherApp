//
//  WeatherForcastPresenter.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 14/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import Foundation

class WeatherForcastPresenter {
    
    private let weatherService: WeatherServiceForcastInterface
    weak private var viewDelegate: WeatherForcastViewControllerDelegate?
    
    init(weatherService: WeatherServiceForcastInterface) {
        self.weatherService = weatherService
        self.weatherService.setDataDelegate(delegate: self)
    }
    
    func setViewDelegate(viewDelegate: WeatherForcastViewControllerDelegate){
        self.viewDelegate = viewDelegate
    }
    
    func getForcastForLocation(locationId: String){
        self.weatherService.getWeatherForcast(locationId: locationId)
    }
    
    
}

//MARK:- Weather Forcast data delegeate
extension WeatherForcastPresenter: WeatherServiceForcastDataDelegate {
    
    func onWeatherForcastFetchDidSucceed(weatherForcastResponse: WeatherForcastResponse) {
        DispatchQueue.main.async {
            self.viewDelegate?.onForcastDataFetchDidSucceed(forcastData: weatherForcastResponse.toWeatherForcastViewModel())
        }
    }
    
    func onWeatherForcastFetchDidFiled() {
        
    }
    
}
