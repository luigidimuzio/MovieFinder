//
//  MovieViewController.swift
//  MovieFinder
//
//  Created by Luigi Di Muzio on 05/07/17.
//  Copyright © 2017 dimuz. All rights reserved.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: Movie! {
        didSet {
            viewModel = MoviewViewModel(movie: movie)
        }
    }
    
    var viewModel: MoviewViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(movie != nil, "MovieViewController cannot be presented without priorly setting it's 'movie' property")
        
        showMovieInfo()
    }
    
    func showMovieInfo() {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.overview
        posterImageView.kf.setImage(with: viewModel.imageURL)
    }
}
