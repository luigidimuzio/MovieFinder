//
//  File.swift
//  MovieFinder
//
//  Created by Luigi Di Muzio on 22/05/16.
//  Copyright © 2016 dimuz. All rights reserved.
//

import Foundation


let TMDbAPIKey: String = "67ac844500323f2b4c069b61dfa5e344"

class TMDbAPIService: MovieService {
    
//    enum MovieListing {
//        case nowPlaying(page: Int)
//        
//        var path: String {
//            switch self {
//            case .nowPlaying:
//                return "movie/now_playing"
//            }
//        }
//        
////        var parameters
//        
//        var request: URLRequest {
//            var r = URLRequest(url: URL(string: baseURL+path+"?api_key="+TMDbAPIKey)!)
//            r.parameters = [:]
//        }
//    }
//    
    
    fileprivate let baseURL = "https://api.themoviedb.org/3/"
    
    fileprivate let session = URLSession.shared
    
    func getMoviesNowInTheatres(completion: @escaping ([Movie]?) -> ()) {
        ///discover/movie?sort_by=popularity.desc
        let url = URL(string: baseURL+"movie/now_playing?api_key="+TMDbAPIKey)!
        let request = URLRequest(url: url)

        session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            
            guard let data = data else {
                print("error calling api")
                completion(nil)
                return
            }
            
            do {
                if
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>,
                    let results = json["results"] as? [Dictionary<String, Any>] {
                    let foundMovies:[Movie] = results.flatMap{ Movie(dictionary: $0)}
                    completion(foundMovies)
                } else {
                    completion(nil)
                }
            }
            catch {
                print("error parsing json")
                completion(nil)
            }
            
        }) .resume()
    }

    func searchMoviesByTitle(_ title: String, completion: @escaping MoviesCallback) {
        guard let escapedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            completion(nil)
            return
        }
        let request = URLRequest(url: URL(string: baseURL+"s=\(escapedTitle)&r=json")!)
        session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            
            guard let data = data else {
                print("error calling api")
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, AnyObject>,
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
            
        }) .resume()
    }

}
