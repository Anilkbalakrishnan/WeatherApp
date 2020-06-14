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
        
        
    }
}

//MARK:- Initialize components
extension WeatherForcastViewController {
    fileprivate func initComponents() {
        self.searchImageView.addTapGesture(target: self, action: #selector(onSearchTap))
    }
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
