//
//  ForcastCollectionViewCell.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 14/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import UIKit

class ForcastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var weatherInfoTile: WeatherInfoTileView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initData(data: WeatherInfo) {
        self.weatherInfoTile.initWithData(data: data)
    }

}
