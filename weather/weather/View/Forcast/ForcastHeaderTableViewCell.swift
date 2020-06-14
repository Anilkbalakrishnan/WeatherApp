//
//  ForcastHeaderTableViewCell.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 14/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import UIKit

class ForcastHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initData(dataSource: ForcastSummary){
        self.dayLabel.text = dataSource.day
        self.dateLabel.text = dataSource.date
        self.weatherIcon.image = dataSource.weatherIconImage
        self.temperatureLabel.text = dataSource.temperatureRange
    }

}
