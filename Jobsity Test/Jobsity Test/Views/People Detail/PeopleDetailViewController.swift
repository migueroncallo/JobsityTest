//
//  PeopleDetailViewController.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/30/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PeopleDetailViewController: UIViewController, NVActivityIndicatorViewable {

    //MARK: - IBOutlets
    
    @IBOutlet weak var artistImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var castTextView: UITextView!
    
    //MARK: - Variables
    
    var person: Person!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configArtistInfo()
        loadData()
    }
    
    //MARK: - Internal helpers
    
    func configArtistInfo(){
        if let image = person.image{
            do{
                let data = try Data(contentsOf: URL(string: image.link)!)
                artistImageView.image = UIImage(data: data)
            }catch{
                artistImageView.image = nil
            }
        }else{
            artistImageView.image = nil
        }
        
        nameLabel.text = person.name
        if let gender = person.gender {genderLabel.text = gender}else{genderLabel.text = ""}
        
        if let c = person.country{
            countryLabel.text = c.name
        }else{
            countryLabel.text = ""
        }
    }
    
    func loadData(){
        startAnimating()
        PeopleAPI.shared.fetchPersonCastById(id: person.id) { (error, credits) in
            self.stopAnimating()
            if let e = error{
                print(e)
            }else if let c = credits{
                var castText = ""
                for credit in c{
                    castText += "\(credit._embedded!.show.name)\n"
                }
                self.castTextView.text = castText
            }
        }
    }
}
