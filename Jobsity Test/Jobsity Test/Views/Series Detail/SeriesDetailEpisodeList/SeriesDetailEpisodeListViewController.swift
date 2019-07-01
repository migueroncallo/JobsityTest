//
//  SeriesDetailEpisodeListViewController.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/30/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import UIKit

class SeriesDetailEpisodeListViewController: UIViewController {
    
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    
    var episodesList: [Int: [Episode]]!
    var delegate: SeriesDetailEpisodeListViewControllerDelegate!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Internal helpers
    
    func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

//MARK: - UITableViewDataSource protocol conformance

extension SeriesDetailEpisodeListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodesList[section + 1]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let episode = episodesList[indexPath.section + 1]![indexPath.row]
        
        cell.textLabel!.text = episode.name
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return episodesList.keys.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(section + 1)"
    }
}

//MARK: - UITableViewDelegate protocol conformance

extension SeriesDetailEpisodeListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodesList[indexPath.section + 1]![indexPath.row]
        delegate.didSelectEpisodes(episode: episode)
    }
}

//MARK: - Episode selection protocol definition
protocol SeriesDetailEpisodeListViewControllerDelegate: class{
    func didSelectEpisodes(episode: Episode)
}
