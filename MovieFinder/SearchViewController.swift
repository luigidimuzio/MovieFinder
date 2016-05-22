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
    
    let service = OMDbService()
    
    var isLoading:Bool = false {
        didSet {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = isLoading
        }
    }
    
    var searchResults:[Movie] = []

    func searchMoviesByTitle(title: String) {
        self.isLoading = true
        service.searchMoviesByTitle(title) { results in
            self.isLoading = false
            guard let movies = results else {
                return
            }
            self.searchResults = movies
            self.reloadTableOnMainThread()
        }
    }
    
    func reloadTableOnMainThread() {
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let searchString = searchBar.text {
            searchMoviesByTitle(searchString)
        }
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ResultMovieCell")
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "ResultMovieCell")
        }
        let movie = searchResults[indexPath.row]
        cell!.textLabel?.text = movie.title
        cell!.detailTextLabel?.text = movie.year
        return cell!
    }
}