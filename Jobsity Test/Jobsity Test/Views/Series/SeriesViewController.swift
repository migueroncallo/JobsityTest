//
//  SeriesViewController.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/27/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SeriesViewController: UIViewController, NVActivityIndicatorViewable{
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    
    //MARK: - Variables
    var seriesPage = 0
    var series = [Series]()
    private let refreshControl = UIRefreshControl()
    
    //MARK: - Lifecycle
    override func viewDidLoad(){
        super.viewDidLoad()
        configCollectionView()
    }
    
    //MARK: - Internal helpers
    
    func configCollectionView(){
        seriesCollectionView.delegate = self
        seriesCollectionView.dataSource = self
        seriesCollectionView.register(UINib(nibName: String(describing: SeriesCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SeriesCollectionViewCell.self))
        if #available(iOS 10.0, *) {
            seriesCollectionView.refreshControl = refreshControl
        } else {
            seriesCollectionView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshSeriesData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)

        loadData()
    }
    
    @objc private func refreshSeriesData(_ sender: Any) {
        seriesPage = 0
        series = [Series]()
        loadData()
    }
    
    func loadData(){
        self.startAnimating()
        SeriesAPI.shared.getAllSeries(page: seriesPage) { (e, series) in
            self.stopAnimating()
            self.refreshControl.endRefreshing()

            if let error = e{
                print(error)
            }else{
                self.seriesPage += 1
                self.series.append(contentsOf: series!)
                self.seriesCollectionView.reloadData()
            }
        }
    }
}

//MARK: - UICollectionViewDataSource protocol conformance
extension SeriesViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = seriesCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SeriesCollectionViewCell.self), for: indexPath) as! SeriesCollectionViewCell
        
        cell.configCell(series: series[indexPath.row], people: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series.count
    }
    
}

//MARK: - UICollectionViewDelegate protocol conformance

extension SeriesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //send to details
        
        let seriesSelected = series[indexPath.row]
        let detailsVC = SeriesDetailViewController()
        detailsVC.series = seriesSelected
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == series.count - 1{
            loadData()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout protocol conformance

extension SeriesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 5, left: 4, bottom: 5, right: 4)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        layout.invalidateLayout()
        
        return CGSize(width: ((self.view.frame.width/2) - 6), height: ((self.view.frame.width / 2) - 6))
    }
}
