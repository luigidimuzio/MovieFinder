//
//  MoviePreviewCell.swift
//  MovieFinder
//
//  Created by Luigi Di Muzio on 05/07/17.
//  Copyright © 2017 dimuz. All rights reserved.
//

import UIKit

class MoviePreviewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with viewModel: MoviewViewModel ) {
        titleLabel.text = viewModel.title
    }
    
    static var nib: UINib {
        return UINib(nibName: "MoviePreviewCell", bundle: nil)
    }
}
