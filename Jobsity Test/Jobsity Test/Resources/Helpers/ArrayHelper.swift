//
//  ArrayHelper.swift
//  Jobsity Test
//
//  Created by Miguel Roncallo on 6/30/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import Foundation

func episodesReducer(episodes: [Episode]) -> [Int: [Episode]]{
    
    var episodesBySeason = [Int:[Episode]]()
    for episode in episodes{
        if episodesBySeason[episode.season] != nil{
           episodesBySeason[episode.season]!.append(episode)
        }else{
          episodesBySeason[episode.season] = [episode]
        }
    }
    
    return episodesBySeason
}
