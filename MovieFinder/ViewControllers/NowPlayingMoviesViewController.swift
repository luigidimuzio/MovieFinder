//
//  NowPlayingMoviesViewController.swift
//  MovieFinder
//
//  Created by Luigi Di Muzio on 05/07/17.
//  Copyright © 2017 dimuz. All rights reserved.
//

import UIKit

class NowPlayingMoviesViewController: UICollectionViewController {
    
    private let service: MovieService = TMDbAPIService()
    fileprivate var movies: [Movie] = []
    fileprivate let moviePreviewCellIdentifier = "MoviePreviewCellIdentifier"
    private var isLoading = false
    
    let cellHeight: CGFloat = 200.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("now-playing.navigation-title", comment: "")
        collectionView?.register(MoviePreviewCell.nib, forCellWithReuseIdentifier: moviePreviewCellIdentifier)
        loadNowPlayingMovies()
    }
    
    func loadNowPlayingMovies() {
        isLoading = true
        service.getMoviesNowInTheatres { [weak self] results in
            guard let results = results, let aliveSelf = self else {
                return
            }
            aliveSelf.isLoading = false
            aliveSelf.movies = results
            aliveSelf.reloadCollectionOnMainThread()
        }
    }

    func reloadCollectionOnMainThread() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}

// MARK: CollectionView datasource

extension NowPlayingMoviesViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moviePreviewCellIdentifier, for: indexPath)
        if let cell = cell as? MoviePreviewCell {
            let movie = movies[indexPath.row]
            let movieViewModel = MoviewViewModel(movie: movie)
            cell.configure(with: movieViewModel)
        }
        return cell
    }
}

// MARK: CollectionView Flow Layout delegate

extension NowPlayingMoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 40
        let height = cellHeight
        return CGSize(width: width, height: height)
    }
}
