//
//  WeatherForcastViewController.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 13/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import UIKit

//MARK:- Protocols
protocol SearchDataDelegate: AnyObject {
    func onLocationSelected(location: PlaceViewModel)
}

protocol WeatherForcastViewControllerDelegate: AnyObject {
    func onForcastDataFetchDidSucceed(forcastData: WeatherForcastViewModel)
}


//MARK:- Weather Forcast View Controller
class WeatherForcastViewController: UIViewController {
    
    @IBOutlet weak var searchIconView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initComponents()
    }
}

//MARK:- Initialize components
extension WeatherForcastViewController {
    fileprivate func initComponents() {
        self.searchIconView.addTapGesture(target: self, action: #selector(onSearchTap))
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

//MARK:- Location search delegate
extension WeatherForcastViewController: SearchDataDelegate {
    func onLocationSelected(location: PlaceViewModel) {
        
    }
}
