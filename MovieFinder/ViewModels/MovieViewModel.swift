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
    let imagesBasePath: String = "https://image.tmdb.org/t/p/w185/"
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        return movie.title
    }
    
    var imageURL: URL? {
        return URL(string: imagesBasePath+movie.posterPath)
    }
    
    var overview: String {
        return movie.overview
    }
    
}
