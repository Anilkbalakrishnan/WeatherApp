//
//  SearchViewController.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 13/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func onSearchDataFetchDidSucceed(places: [PlaceViewModel])
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    private var dataSource = [PlaceViewModel]()
    weak var delegate: SearchDataDelegate?
    private let searchLocationPresenter = SearchLocationPresenter(weatherService: WeatherService.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initComponents()
    }
    
}


//MARK:- Initializations
extension SearchViewController {
    
    fileprivate func initComponents() {
        self.initTableView()
        self.initSerchBar()
    }
    
    fileprivate func initTableView() {
        self.searchResultTableView.dataSource = self
        self.searchResultTableView.delegate = self
    }
    
    fileprivate func initSerchBar() {
        self.searchBar.delegate = self
        self.searchLocationPresenter.setViewDelegate(viewDelegate: self)
        searchBar.showsCancelButton = true
    }
}


//MARK:- Search result table view
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let placeTableViewCell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.placeTableViewCell) as? PlacesTableViewCell {
            placeTableViewCell.initWithData(datasource: self.dataSource[indexPath.row])
            return placeTableViewCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLocation = self.dataSource[indexPath.row]
        self.delegate?.onLocationSelected(location: selectedLocation)
    }
}


//MARK:- Searchbar delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchLocation(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
    
    private func searchLocation(searchText: String) {
        self.searchLocationPresenter.getLocationByName(name: searchText)
    }
}


//MARK:- ViewDelegate
extension SearchViewController: SearchViewControllerDelegate {
    func onSearchDataFetchDidSucceed(places: [PlaceViewModel]) {
        self.dataSource = places
        self.searchResultTableView.reloadData()
    }
}
