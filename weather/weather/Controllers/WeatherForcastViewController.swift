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
    
    @IBOutlet weak var forcastTableView: UITableView!
    
    private var dataSource: WeatherForcastViewModel?
    private let forcastPresenter = WeatherForcastPresenter(weatherService: WeatherService.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initComponents()
        self.forcastPresenter.setViewDelegate(viewDelegate: self)
    }
    
}

//MARK:- Initialize components
extension WeatherForcastViewController {
    
    fileprivate func initComponents() {
        self.searchIconView.addTapGesture(target: self, action: #selector(onSearchTap))
        self.initForcastTableView()
    }
    
    fileprivate func initForcastTableView() {
        self.registerTableViewCell()
        self.forcastTableView.delegate = self
        self.forcastTableView.dataSource = self
    }
    
    fileprivate func registerTableViewCell() {
        let forcastTableViewCell = UINib(nibName: "ForcastTableViewCell",bundle: nil)
        self.forcastTableView.register(forcastTableViewCell, forCellReuseIdentifier: ReuseIdentifier.weatherForcastTableViewCell)
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
        self.forcastPresenter.getForcastForLocation(locationId: location.id)
    }
}


extension WeatherForcastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let dataSource = self.dataSource  else { return 0 }
        return dataSource.weatherForcast.forcasts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataSource = self.dataSource  else { return UITableViewCell() }
        
        if let forcastTableViewCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.weatherForcastTableViewCell) as? ForcastTableViewCell {
            forcastTableViewCell.initData(dataSource:dataSource.weatherForcast.forcasts[indexPath.section].weatherPrediction)
            return forcastTableViewCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dataSource = self.dataSource  else { return UIView() }
        if let headerSection = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.weatherForcastTableViewHeader) as? ForcastHeaderTableViewCell {
            headerSection.initData(dataSource: dataSource.weatherForcast.forcasts[section].forcastSummary)
            return headerSection
        }
        return UIView()
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}


extension WeatherForcastViewController: WeatherForcastViewControllerDelegate {
    func onForcastDataFetchDidSucceed(forcastData: WeatherForcastViewModel) {
        self.dataSource = forcastData
        self.forcastTableView.reloadData()
    }
    
    
}
