//
//  MoviePreviewCell.swift
//  MovieFinder
//
//  Created by Luigi Di Muzio on 05/07/17.
//  Copyright © 2017 dimuz. All rights reserved.
//

import UIKit
import Kingfisher

class MoviePreviewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with viewModel: MoviewViewModel ) {
        titleLabel.text = viewModel.title
        imageView.kf.setImage(with: viewModel.imageURL)
    }
    
    static var nib: UINib {
        return UINib(nibName: "MoviePreviewCell", bundle: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }
    
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.3
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
}
