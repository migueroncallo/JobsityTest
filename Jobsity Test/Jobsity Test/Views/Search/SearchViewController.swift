//
//  SearchViewController.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/30/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SearchViewController: UIViewController, NVActivityIndicatorViewable {

    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    //MARK: - Variables
    
    var peopleResults = [People]()
    var showsResults = [SeriesSearchResult]()
    var isShowsSelected = true
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        configSearchBar()
    }
    
    //MARK: - IBActions
    
    @IBAction func didChangeSection(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            isShowsSelected = true
        }else{
            isShowsSelected = false
        }
        resultsCollectionView.reloadData()
    }
    
    //MARK: - Internal helpers
    
    func configCollectionView(){
        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self
        resultsCollectionView.register(UINib(nibName: String(describing: SeriesCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SeriesCollectionViewCell.self))
    }
    
    func configSearchBar(){
        searchBar.delegate = self
    }
}

//MARK: - UICollectionViewDataSource protocol conformance
extension SearchViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resultsCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SeriesCollectionViewCell.self), for: indexPath) as! SeriesCollectionViewCell
        
        if isShowsSelected{
            cell.configCell(series: showsResults[indexPath.row].show, people: nil)
        }else{
            cell.configCell(series: nil, people: peopleResults[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isShowsSelected {return showsResults.count}
        return peopleResults.count
    }
    
}

//MARK: - UICollectionViewDelegate protocol conformance

extension SearchViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //send to details
        
        if isShowsSelected{
            let seriesSelected = showsResults[indexPath.row].show
            let showsDetailsVC = SeriesDetailViewController()
            showsDetailsVC.series = seriesSelected
            self.navigationController?.pushViewController(showsDetailsVC, animated: true)
        }else{
            let personSelected = peopleResults[indexPath.row].person
            let peopleDetailsVC = PeopleDetailViewController()
            peopleDetailsVC.person = personSelected
            self.navigationController?.pushViewController(peopleDetailsVC, animated: true)
        }
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout protocol conformance

extension SearchViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 5, left: 4, bottom: 5, right: 4)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        layout.invalidateLayout()
        
        return CGSize(width: ((self.view.frame.width/2) - 6), height: ((self.view.frame.width / 2) - 6))
    }
}

//MARK: - UISearchBarDelegate protocol conformance
extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        startAnimating()
        self.view.endEditing(true)
        if searchBar.text != ""{
            let searchText = searchBar.text!
            SearchAPI.shared.searchFor(series: isShowsSelected, query: searchText) { (error, series, people) in
                self.stopAnimating()
                if let e = error{
                    print(e)
                }else if let s = series{
                    self.showsResults = s
                }else if let p = people{
                    self.peopleResults = p
                }
                self.resultsCollectionView.reloadData()
            }
        }else{
            stopAnimating()
        }
    }
}
