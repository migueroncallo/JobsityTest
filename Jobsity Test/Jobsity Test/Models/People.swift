//
//  People.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/30/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import Foundation

struct People: Codable{
    var person: Person
}

struct Person:Codable{
    var id: Int
    var url: String
    var gender: String?
    var name: String
    var country: Country?
    var image: PeopleImage?
}

struct Country: Codable{
    var name: String
}

struct PeopleImage: Codable{
    var link: String
    
    private enum imageEncodingKeys: String, CodingKey{
        case link = "original"
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: imageEncodingKeys.self)
        link = try container.decode(String.self, forKey: .link)
    }
}

struct CastCredits: Codable{
    var _embedded: EmbeddedShows?
}

struct EmbeddedShows: Codable{
    var show: Series
}

//{
//    score: 34.68433,
//    person: {
//        id: 172658,
//        url: "http://www.tvmaze.com/people/172658/lauren-bush-lauren",
//        name: "Lauren Bush Lauren",
//        country: {
//            name: "United States",
//            code: "US",
//            timezone: "America/New_York"
//        },
//        birthday: "1984-06-25",
//        deathday: null,
//        gender: "Female",
//        image: {
//            medium: "http://static.tvmaze.com/uploads/images/medium_portrait/108/272410.jpg",
//            original: "http://static.tvmaze.com/uploads/images/original_untouched/108/272410.jpg"
//        },
//        _links: {
//            self: {
//                href: "http://api.tvmaze.com/people/172658"
//            }
//        }
//    }
//}
