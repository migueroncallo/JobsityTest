//
//  Episode.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/30/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import Foundation

struct Episode: Codable{
    var id: Int
    var url: String
    var name: String
    var season: Int
    var number: Int
    var summary: String?
    var image: EpisodeImage?
}

struct EpisodeImage: Codable{
    var link: String
    
    private enum imageEncodingKeys: String, CodingKey{
        case link = "original"
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: imageEncodingKeys.self)
        link = try container.decode(String.self, forKey: .link)
    }
}

//id: 1,
//url: "http://www.tvmaze.com/episodes/1/under-the-dome-1x01-pilot",
//name: "Pilot",
//season: 1,
//number: 1,
//airdate: "2013-06-24",
//airtime: "22:00",
//airstamp: "2013-06-25T02:00:00+00:00",
//runtime: 60,
//image: {
//    medium: "http://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg",
//    original: "http://static.tvmaze.com/uploads/images/original_untouched/1/4388.jpg"
//},
//summary: "<p>When the residents of Chester's Mill find themselves trapped under a massive transparent dome with no way out, they struggle to survive as resources rapidly dwindle and panic quickly escalates.</p>",
//_links: {
//    self: {
//        href: "http://api.tvmaze.com/episodes/1"
//    }
//}
//}
