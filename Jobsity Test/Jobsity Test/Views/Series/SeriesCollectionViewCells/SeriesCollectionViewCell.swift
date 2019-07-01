//
//  SeriesCollectionViewCell.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/27/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import UIKit

class SeriesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var seriesImageView: UIImageView!
    
    @IBOutlet weak var seriesTitle: UILabel!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Internal helpers
    
    func configCell(series: Series?, people: People?){
        if let s = series{
            if let image = s.image{
                do{
                    let data = try Data(contentsOf: URL(string: image.link)!)
                    seriesImageView.image = UIImage(data: data)
                }catch{
                    seriesImageView.image = nil
                }
            }else{
                seriesImageView.image = nil
            }
            
            seriesTitle.text = s.name
        }else if let p = people{
            
            if let image = p.person.image{
                do{
                    let data = try Data(contentsOf: URL(string: image.link)!)
                    seriesImageView.image = UIImage(data: data)
                }catch{
                    seriesImageView.image = nil
                }
            }else{
                seriesImageView.image = nil
            }
            
            seriesTitle.text = p.person.name
        }
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
    }
    
}
