//
//  SearchAPI.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/30/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import Foundation
import Alamofire

class SearchAPI{
    static let shared = SearchAPI()
    
    func searchFor(series: Bool, query: String, _ cb: @escaping(Error?, [SeriesSearchResult]?, [People]?)->()){
        var search = "people"
        if series{
            search = "shows"
        }
           
         guard let url = URL(string: "\(basicUrl)/search/\(search)?q=\(query)") else {return}
        Alamofire.request(url, method: .get)
        .validate()
        .responseJSON { (response) in
            switch response.result{
            case .success:
                if series{
                    let decoder = JSONDecoder()
                    let series = try! decoder.decode([SeriesSearchResult].self, from: response.data!)
                    cb(nil, series, nil)
                }else{
                    let decoder = JSONDecoder()
                    let people = try! decoder.decode([People].self, from: response.data!)
                    cb(nil, nil, people)
                }
            case .failure(let error):
                cb(error, nil, nil)
            }
        }
    }
}
