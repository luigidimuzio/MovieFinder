//
//  MoviePreviewNavigationController.swift
//  MovieFinder
//
//  Created by Luigi Di Muzio on 05/07/17.
//  Copyright © 2017 dimuz. All rights reserved.
//

import UIKit


//TODO: make protocol for generic uiviewcontroller with animatable cell
// also maybe could be enough having the frame?

class MoviePreviewNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension MoviePreviewNavigationController: UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // TODO:
        return nil
        
        guard operation == .push else {
            return nil
        }
        if let fromVC = fromVC as? NowPlayingMoviesViewController,
            let _ = toVC as? MovieViewController,
            let cell = fromVC.selectedCell {
             return MoviePreviewOpeningAnimator(withDuration: 2.0, forTransitionType: .Presenting, fromCell: cell)
        }
        return nil
    }
}
