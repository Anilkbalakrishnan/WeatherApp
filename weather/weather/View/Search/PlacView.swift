//
//  PlacView.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 13/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import UIKit

class PlacView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reagingLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    private var dataSource: PlaceViewModel?
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initPlacView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initPlacView()
    }
    
    private func initPlacView(){
        Bundle.main.loadNibNamed("PlaceView", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth]
    }
    
    func initWithData(dataSource: PlaceViewModel){
        self.nameLabel.text = dataSource.name
        self.reagingLabel.text = "\(dataSource.category), \(dataSource.subRegion) (\(dataSource.region)) "
        self.temperatureLabel.text = String(Int(dataSource.currentTemperature)) + "°"
        self.weatherIconImageView.image = UIImage(named: dataSource.weatherIconName)
    }
}
