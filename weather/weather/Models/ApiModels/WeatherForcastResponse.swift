//
//  WeatherForcastResponse.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 13/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct WeatherForcastResponse: Decodable {
    let created, update: Date
    let shortIntervals: [ShortInterval]
    let longIntervals: [LongInterval]
    let links: Link

    enum CodingKeys: String, CodingKey {
        case created, update, shortIntervals, longIntervals
        case links = "_links"
    }
}

// MARK: - Links
struct Link: Decodable {
    let linksSelf: Reference
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - LongInterval
struct LongInterval: Decodable {
    let symbol: Symbol
    let precipitation, temperature: Precipitation
    let wind: Wind
    let feelsLike, pressure: DewPoint
    let cloudCover: CloudCover
    let humidity, dewPoint: DewPoint
    let start, end: Date
    let uvIndex: DewPoint?
}

// MARK: - CloudCover
struct CloudCover: Decodable {
    let value, high, middle, low: Int
    let fog: Int
}

// MARK: - DewPoint
struct DewPoint: Decodable {
    let value: Double?
}

// MARK: - Precipitation
struct Precipitation: Decodable {
    let min, max, value: Double
    let pop: Int?
}

// MARK: - Symbol
struct Symbol: Decodable {
    let sunup: Bool
    let n, clouds, precip: Int
    let symbolVar: String?

    enum CodingKeys: String, CodingKey {
        case sunup, n, clouds, precip
        case symbolVar = "var"
    }
}

enum Var: String, Decodable {
    case moon = "Moon"
    case sun = "Sun"
    
}

// MARK: - Wind
struct Wind: Decodable {
    let direction: Int
    let gust: Double?
    let speed: Double
}

// MARK: - ShortInterval
struct ShortInterval: Decodable {
    let symbol: Symbol
    let precipitation: Precipitation?
    let temperature: DewPoint
    let wind: Wind
    let feelsLike, pressure, uvIndex: DewPoint
    let cloudCover: CloudCover
    let humidity, dewPoint: DewPoint
    let start, end: Date
}

