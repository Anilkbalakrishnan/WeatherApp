//
//  WeatherApiConstant.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 13/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import Foundation


struct WeatherApiConstant {
    static let baseUrl: String = "https://www.yr.no/"
    static let searchPath: String = "api/v0/locations/Search?"
    static let forcastPathPrefix: String = "api/v0/locations/"
    static let forcastPathSuffix: String = "/forecast"
}
