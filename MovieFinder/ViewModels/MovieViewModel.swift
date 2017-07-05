//
//  MovieViewModel.swift
//  MovieFinder
//
//  Created by Luigi Di Muzio on 05/07/17.
//  Copyright © 2017 dimuz. All rights reserved.
//

import Foundation

struct MoviewViewModel {
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        return movie.title
    }
    
}
