//
//  EpisodeDetailViewController.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/30/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var episodeImage: UIImageView!
    
    @IBOutlet weak var episodeNameLabel: UILabel!
    
    @IBOutlet weak var seasonNumberLabel: UILabel!
    
    @IBOutlet weak var chapterNumberLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK: - Variables
    
    var episode: Episode!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configEpisodeInfo()
    }
    
    //MARK: - Internal helpers
    
    func configEpisodeInfo(){
        episodeNameLabel.text = episode.name
        seasonNumberLabel.text = "Season \(episode.season)"
        chapterNumberLabel.text = "Chapter \(episode.number)"
        
        if let image = episode.image{
            do{
                let data = try Data(contentsOf: URL(string: image.link)!)
                episodeImage.image = UIImage(data: data)
            }catch{
                episodeImage.image = nil
            }
        }else{
            episodeImage.image = nil
        }
        
        if let s = episode.summary{
            descriptionTextView.text = s
        }else{
            descriptionTextView.text = ""
        }
        
    }

}
