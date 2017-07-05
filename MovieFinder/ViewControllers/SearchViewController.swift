//
//  ViewController.swift
//  MovieFinder
//
//  Created by Luigi Di Muzio on 22/05/16.
//  Copyright © 2016 dimuz. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let service: MovieService = TMDbAPIService()
    
    var isLoading:Bool = false {
        didSet {
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        }
    }
    
    var searchResults:[Movie] = []

//    func searchMoviesByTitle(_ title: String) {
//        self.isLoading = true
//        service.searchMoviesByTitle(title) { results in
//            self.isLoading = false
//            guard let movies = results else {
//                return
//            }
//            self.searchResults = movies
//            self.reloadTableOnMainThread()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isLoading = true
        service.getMoviesNowInTheatres { results in
            self.isLoading = false
            guard let movies = results else {
                return
            }
            self.searchResults = movies
            self.reloadTableOnMainThread()
        }
    }
    
    func reloadTableOnMainThread() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        if let searchString = searchBar.text {
//            searchMoviesByTitle(searchString)
//        }
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ResultMovieCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "ResultMovieCell")
        }
        let movie = searchResults[indexPath.row]
        cell!.textLabel?.text = movie.title
//        cell!.detailTextLabel?.text = movie.year
        return cell!
    }
}
