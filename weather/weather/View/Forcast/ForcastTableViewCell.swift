//
//  ForcastTableViewCell.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 14/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import UIKit

class ForcastTableViewCell: UITableViewCell {

    @IBOutlet weak var forcastCollectionView: UICollectionView!
    
    private var dataSource: [WeatherInfo] = [WeatherInfo]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initComponent()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func initData(dataSource: [WeatherInfo]) {
        self.dataSource = dataSource
        self.forcastCollectionView.reloadData()
    }

    
}

//MARK:- Init
extension ForcastTableViewCell {
    
    fileprivate func initComponent(){
        initCollecitonView()
    }
    
    fileprivate func initCollecitonView(){
        registerCollectionViewCells()
        self.forcastCollectionView.dataSource = self
        self.forcastCollectionView.delegate = self
    }
    
    fileprivate func registerCollectionViewCells() {
        let weatherForcastCollectonViewCell = UINib(nibName: "ForcastCollectionViewCell", bundle: nil)
        self.forcastCollectionView.register(weatherForcastCollectonViewCell, forCellWithReuseIdentifier: ReuseIdentifier.weatherInfoCollectionViewCell)
    }
}

extension ForcastTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let weatherInfoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.weatherInfoCollectionViewCell, for: indexPath) as? ForcastCollectionViewCell {
            weatherInfoCollectionViewCell.initData(data: dataSource[indexPath.row])
            return weatherInfoCollectionViewCell
        }
        return UICollectionViewCell()
    }
    
    
}
