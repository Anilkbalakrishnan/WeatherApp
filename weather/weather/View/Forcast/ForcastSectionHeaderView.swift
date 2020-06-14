//
//  ForcastSectionHeaderView.swift
//  weather
//
//  Created by Anil Kallamkatil Balakrishnan on 14/06/2020.
//  Copyright © 2020 nrk. All rights reserved.
//

import UIKit

class ForcastSectionHeaderView: UIView {

    
    @IBOutlet var contentView: ForcastSectionHeaderView!
    @IBOutlet weak var dayLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initForcastSectionHeaderView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initForcastSectionHeaderView()
    }
    
    private func initForcastSectionHeaderView(){
        Bundle.main.loadNibNamed("ForcastSectionHeaderView", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth]
    }
    
    
    
    
    func initData(data: ForcastSummary) {
        self.dayLabel.text = data.day
    }
    
}
