//
//  SeriesDetailInfoViewController.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/30/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SeriesDetailInfoViewController: UIViewController, NVActivityIndicatorViewable {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var airTimeLabel: UILabel!
    
    @IBOutlet weak var airDaysLabel: UILabel!
    
    @IBOutlet weak var genresListLabel: UILabel!
    
    @IBOutlet weak var descriptionTextview: UITextView!
    
    
    //MARK: - Properties
    
    var seriesInfo: Series!

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSeriesInfo()
    }
    
    //MARK: - Internal helpers
    
    func configSeriesInfo(){
        airTimeLabel.text = seriesInfo.schedule.time
        var airDaysText = ""
        for day in seriesInfo.schedule.days{
            airDaysText += "\(day)\n"
        }
        airDaysLabel.text = airDaysText
        airDaysLabel.sizeToFit()
        
        var genresListText = ""
        
        for genre in seriesInfo.genres{
            genresListText += "\(genre)\n"
        }
        genresListLabel.text = genresListText
        genresListLabel.sizeToFit()
        
        descriptionTextview.text = seriesInfo.summary
    }
}
