//
//  Series.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/27/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import Foundation

struct Series: Codable{
    var id: Int
    var name: String
    var genres: [String]
    var summary: String
    var image: SeriesImage?
    var schedule: Schedule
    var _embedded: Embedded?
    
//    private enum seriesEncodingKeys: String, CodingKey{
//        case embedded = "_embedded"
//    }
//
//    init(from decoder: Decoder) throws{
//        let container = try decoder.container(keyedBy: seriesEncodingKeys.self)
//        embedded = try container.decode(Embedded.self, forKey: .embedded)
//    }
    
}

struct Schedule: Codable{
    var time: String
    var days: [String]
}

struct SeriesImage: Codable{
    var link: String
    
    private enum imageEncodingKeys: String, CodingKey{
        case link = "original"
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: imageEncodingKeys.self)
        link = try container.decode(String.self, forKey: .link)
    }
}

struct Embedded: Codable{
    var episodes: [Episode]
}

//id: 1,
//url: "http://www.tvmaze.com/shows/1/under-the-dome",
//name: "Under the Dome",
//type: "Scripted",
//language: "English",
//genres: [
//"Drama",
//"Science-Fiction",
//"Thriller"
//],
//status: "Ended",
//runtime: 60,
//premiered: "2013-06-24",
//officialSite: "http://www.cbs.com/shows/under-the-dome/",
//schedule: {
//    time: "22:00",
//    days: [
//    "Thursday"
//    ]
//},
//rating: {
//    average: 6.5
//},
//weight: 90,
//network: {
//    id: 2,
//    name: "CBS",
//    country: {
//        name: "United States",
//        code: "US",
//        timezone: "America/New_York"
//    }
//},
//webChannel: null,
//externals: {
//    tvrage: 25988,
//    thetvdb: 264492,
//    imdb: "tt1553656"
//},
//image: {
//    medium: "http://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg",
//    original: "http://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
//},
//summary: "<p><b>Under the Dome</b> is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome. The town's inhabitants must deal with surviving the post-apocalyptic conditions while searching for answers about the dome, where it came from and if and when it will go away.</p>",
//updated: 1558460639,
//_links: {
//    self: {
//        href: "http://api.tvmaze.com/shows/1"
//    },
//    previousepisode: {
//        href: "http://api.tvmaze.com/episodes/185054"
//    }
//}
//}
