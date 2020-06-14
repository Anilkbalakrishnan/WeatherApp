//
//  PlacesTableViewCell.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 14/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    @IBOutlet weak var placeView: PlacView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithData(datasource: PlaceViewModel){
        self.placeView.initWithData(dataSource: datasource)
    }
    
    
}
