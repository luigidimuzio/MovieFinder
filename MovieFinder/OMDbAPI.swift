//
//  File.swift
//  MovieFinder
//
//  Created by Luigi Di Muzio on 22/05/16.
//  Copyright © 2016 dimuz. All rights reserved.
//

import Foundation


typealias MoviesCallback = ([Movie]?) -> Void

class OMDbService {

    private let baseUrl = "https://www.omdbapi.com/?"
    
    private let session = NSURLSession.sharedSession()
    
    func searchMoviesByTitle(title: String, completion: MoviesCallback) {
        let request = NSURLRequest(URL: NSURL(string: baseUrl+"s=\(title)&r=json")!)
        session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            guard let data = data else {
                print("error calling api")
                completion(nil)
                return
            }
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? Dictionary<String, AnyObject>,
                    let searchResults = json["Search"] as? [Dictionary<String, String>] {
                    let foundMovies:[Movie] = searchResults.flatMap{ Movie(dictionary: $0)}
                    completion(foundMovies)
                } else {
                    completion(nil)
                }
            }
            catch {
                print("error parsing json")
                completion(nil)
            }
            
        }.resume()
    }

}