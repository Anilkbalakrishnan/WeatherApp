//
//  WeatherForcastViewController.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 13/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import UIKit

class WeatherForcastViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        WeatherService.shared.searchLocationByName(searchText: "oslo")
        WeatherService.shared.getWeatherForcast(locationId: "1-72837")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
