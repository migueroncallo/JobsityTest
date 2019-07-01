//
//  SeriesDetailViewController.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/27/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import UIKit
import PagerMenu
import NVActivityIndicatorView

class SeriesDetailViewController: UIViewController, NVActivityIndicatorViewable {
    
    //MARK: - IBOutlets
    @IBOutlet weak var showImageView: UIImageView!
    
    @IBOutlet weak var showNameLabel: UILabel!
    //MARK: - Variables
    
    var series: Series!
    var pageMenu: CAPSPageMenu?
    var episodesList = [Int: [Episode]]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        startAnimating()
    }
    
    //MARK: - Internal helpers
    
    func loadData(){
        SeriesAPI.shared.fetchSeriesById(id: series.id) { (error, series) in
            self.stopAnimating()
            if let s = series{
                self.episodesList = episodesReducer(episodes: s._embedded!.episodes)
                self.series = s
                self.configBasicInfo()
                self.configPager()
            }else{
                print(error!)
            }
        }
    }
    
    func configBasicInfo(){
        if let image = series.image{
            do{
                let data = try Data(contentsOf: URL(string: image.link)!)
                showImageView.image = UIImage(data: data)
            }catch{
                showImageView.image = nil
            }
        }else{
            showImageView.image = nil
        }
        showNameLabel.text = series.name
    }
    
    func configPager(){
        var viewsArray = [UIViewController]()
        let infoView = SeriesDetailInfoViewController()
        infoView.seriesInfo = series
        infoView.title = "Information"
        viewsArray.append(infoView)
        
        let episodesListView = SeriesDetailEpisodeListViewController()
        episodesListView.title = "Episodes"
        episodesListView.episodesList = self.episodesList
        episodesListView.delegate = self
        viewsArray.append(episodesListView)
        
        let pageMenuFrame = CGRect(x: 0, y: 350, width: self.view.frame.width, height: (self.view.frame.height * 0.8))
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(2),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: viewsArray, frame: pageMenuFrame, pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
    }
}
//MARK: - SeriesDetailEpisodeListViewControllerDelegate protocol conformance
extension SeriesDetailViewController: SeriesDetailEpisodeListViewControllerDelegate{
    func didSelectEpisodes(episode: Episode) {
        let episodeDetailVC = EpisodeDetailViewController()
        episodeDetailVC.episode = episode
        self.navigationController?.pushViewController(episodeDetailVC, animated: true)
    }
}
