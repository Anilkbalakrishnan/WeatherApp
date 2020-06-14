//
//  WeatherForcastViewController.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 13/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import UIKit
protocol SearchDataDelegate: AnyObject {
    func onLocationSelected(location: PlaceViewModel)
}

class WeatherForcastViewController: UIViewController {
    
    @IBOutlet weak var searchImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchImageView.addTapGesture(target: self, action: #selector(onSearchTap))
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

extension WeatherForcastViewController {
    
    @objc
    func onSearchTap(){
        self.showSearchView()
    }
    
    private func showSearchView(){
        self.performSegue(withIdentifier: "segueToSearch", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchViewController = segue.destination as? SearchViewController {
            searchViewController.delegate = self
        }
    }
}


extension WeatherForcastViewController: SearchDataDelegate {
    func onLocationSelected(location: PlaceViewModel) {
        
    }
}
