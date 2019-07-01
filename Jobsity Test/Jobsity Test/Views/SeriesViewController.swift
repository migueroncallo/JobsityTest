//
//  SeriesViewController.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/27/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import UIKit

class SeriesViewController: UIViewController{
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    
    //MARK: - Variables
    var seriesPage = 0
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
