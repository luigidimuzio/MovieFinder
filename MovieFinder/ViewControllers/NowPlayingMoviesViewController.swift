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
    fileprivate var originFrame: CGRect = .zero
    
    let cellHeight: CGFloat = 200.0
    
    var selectedCell: MoviePreviewCell?
    
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
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

// MARK: CollectionView delegate

extension NowPlayingMoviesViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieVC = storyboard?.instantiateViewController(withIdentifier: "MovieViewController") as? MovieViewController,
            let cell = collectionView.cellForItem(at: indexPath) as? MoviePreviewCell
        else {
            return
        }
        let test = self.navigationController as? MoviePreviewNavigationController
        movieVC.transitioningDelegate = test
        movieVC.movie = movies[indexPath.row]
        selectedCell = cell
        navigationController?.pushViewController(movieVC, animated: true)
//        present(movieVC, animated: true, completion: nil)
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

// MARK: Detail view controller presenting

//extension NowPlayingMoviesViewController: UIViewControllerTransitioningDelegate {
//    
//    func animationController(forPresented presented: UIViewController,
//                             presenting: UIViewController,
//                             source: UIViewController)
//        -> UIViewControllerAnimatedTransitioning?
//    {
//        guard let selectedCell = selectedCell else {
//            return nil
//        }
//        return MoviePreviewOpeningAnimator(withDuration: 5.0, forTransitionType: .Presenting, fromCell: selectedCell)
//    }
//    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        guard let selectedCell = selectedCell else {
//            return nil
//        }
//        return MoviePreviewOpeningAnimator(withDuration: 5.0, forTransitionType: .Dismissing, fromCell: selectedCell)
//    }
//    
//}
