//
//  Service.swift
//  MovieFinder
//
//  Created by Luigi Di Muzio on 05/07/17.
//  Copyright © 2017 dimuz. All rights reserved.
//

import Foundation

protocol MovieService {
    typealias MoviesCallback = ([Movie]?) -> Void

    func getMoviesNowInTheatres(completion: @escaping MoviesCallback)
}
