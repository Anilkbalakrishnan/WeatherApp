//
//  WeatherInfoTileView.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 14/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import UIKit

class WeatherInfoTileView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initWeatherInfoTileView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initWeatherInfoTileView()
    }
    
    private func initWeatherInfoTileView(){
        Bundle.main.loadNibNamed("WeatherInfoTileView", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = []
    }
    
    func initWithData(data: WeatherInfo) {
        self.temperatureLabel.text = data.temperature
        self.timeLabel.text = data.time
        self.weatherIconImageView.image = UIImage(named: data.iconName)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
