//
//  SearchLocationResponse.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 13/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import Foundation

// MARK: - SearchLocationResponse
struct SearchLocationResponse: Decodable {
    let totalResults: Int
    let links: Links
    let embedded: Embedded

    enum CodingKeys: String, CodingKey {
        case totalResults
        case links = "_links"
        case embedded = "_embedded"
    }
}

// MARK: - Embedded
struct Embedded: Decodable {
    let location: [Location]
}

// MARK: - Location
struct Location: Decodable {
    let category: Category
    let id, name: String
    let position: Position
    let elevation: Int
    let timeZone: String
    let urlPath: String
    let country, region, subregion: Category?
    let links: LocationLinks?

    enum CodingKeys: String, CodingKey {
        case category, id, name, position, elevation, timeZone, urlPath, country, region, subregion
        case links = "_links"
    }
}

// MARK: - Category
struct Category: Decodable {
    let id, name: String
}

// MARK: - LocationLinks
struct LocationLinks: Decodable {
    let linksSelf, celestialevents, forecast, mapfeature: Reference?
    let notifications: Reference?
    let extremeforecasts, now: Reference?
//    let observations: [Reference]?
    let airqualityforecast, pollen, bathingtemperatures: Reference?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case celestialevents, forecast, mapfeature, notifications, extremeforecasts, now, airqualityforecast, pollen, bathingtemperatures
    }
}

// MARK: - SelfElement
struct Reference: Decodable {
    let href: String
}

// MARK: - Position
struct Position: Decodable {
    let lat, lon: Double
}

enum TimeZone: String, Codable {
    case europeOslo = "Europe/Oslo"
}

// MARK: - Links
struct Links: Decodable {
    let linksSelf: Reference
    let page, search: Page
    let location: [Reference]

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case page, search, location
    }
}

// MARK: - Page
struct Page: Decodable {
    let href: String
    let templated: Bool
}
