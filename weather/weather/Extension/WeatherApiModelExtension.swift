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
