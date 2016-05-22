//
//  Movie.swift
//  MovieFinder
//
//  Created by Luigi Di Muzio on 22/05/16.
//  Copyright © 2016 dimuz. All rights reserved.
//

import Foundation

struct Movie {
    let imdbID: String
    let title: String
    let year: String
    
    init?(dictionary: Dictionary<String, String>) {
        if let imdbID = dictionary["Title"], let title = dictionary["Title"], let year = dictionary["Year"] {
            self.imdbID = imdbID
            self.title = title
            self.year = year
        } else {
            return nil
        }
    }
}