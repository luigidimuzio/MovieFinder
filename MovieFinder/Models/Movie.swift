//
//  Movie.swift
//  MovieFinder
//
//  Created by Luigi Di Muzio on 22/05/16.
//  Copyright © 2016 dimuz. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    
    init?(dictionary: Dictionary<String, Any>) {
        guard
            let id = dictionary["id"] as? Int,
            let title = dictionary["title"] as? String
        else {
            return nil
        }
        
        self.title = title
        self.id = id
    }
}
