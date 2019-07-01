//
//  PeopleAPI.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/30/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import Foundation
import Alamofire

class PeopleAPI{
    static let shared = PeopleAPI()
    
    func fetchPersonCastById(id: Int, _ cb: @escaping(Error?, [CastCredits]?)->()){
        guard let url = URL(string: "\(basicUrl)/people/\(id)/castcredits?embed=show") else {return}
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { (response) in
                switch response.result{
                case .success:
                    let decoder = JSONDecoder()
                    let credits = try! decoder.decode([CastCredits].self, from: response.data!)
                    cb(nil, credits)
                case .failure(let error):
                    cb(error, nil)
                }
        }
    }
}
