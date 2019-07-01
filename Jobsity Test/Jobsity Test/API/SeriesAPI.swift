//
//  SeriesAPI.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/27/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import Foundation
import Alamofire

class SeriesAPI{
    static let shared = SeriesAPI()
    
    func getAllSeries(page: Int, _ cb: @escaping (Error?, [Series]?)-> ()){
        guard let url = URL(string: "\(basicUrl)/shows?page=\(page)&embed=episodes") else {return}
        
        Alamofire.request(url, method: .get)
        .validate()
            .responseJSON { (response) in
                switch response.result{
                    case .success:
                        let decoder = JSONDecoder()
                        let series = try! decoder.decode([Series].self, from: response.data!)
                        cb(nil, series)
                    case .failure(let error):
                        cb(error, nil)
                }
        }
    }
    
    func fetchSeriesById(id: Int, _ cb: @escaping(Error?, Series?)->()){
        guard let url = URL(string: "\(basicUrl)/shows/\(id)?embed=episodes") else {return}

        Alamofire.request(url, method: .get)
        .validate()
            .responseJSON { (response) in
                switch response.result{
                case .success:
                    let decoder = JSONDecoder()
                    let series = try! decoder.decode(Series.self, from: response.data!)
                    cb(nil, series)
                case .failure(let error):
                    cb(error, nil)
                }
        }
    }
}
