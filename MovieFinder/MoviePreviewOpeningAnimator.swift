//
//  MoviePreviewOpeningAnimator.swift
//  MovieFinder
//
//  Created by Luigi Di Muzio on 05/07/17.
//  Copyright © 2017 dimuz. All rights reserved.
//

import UIKit

enum TransitionType {
    case Presenting, Dismissing
}

class MoviePreviewOpeningAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originCell: MoviePreviewCell
    var originImageView: UIImageView
    var isPresenting: Bool
    var duration: TimeInterval
    
    init(withDuration duration: TimeInterval = 1.0, forTransitionType type: TransitionType, fromCell cell: MoviePreviewCell) {
        self.duration = duration
        self.isPresenting = type == .Presenting
        self.originImageView = cell.imageView
        self.originCell = cell
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.isPresenting {
            animatePresenting(using: transitionContext)
        } else {
            //containerView.insertSubview(toView, belowSubview: fromView)
        }
    }
    
    func animatePresenting(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView
        
        guard
            let fromView = transitionContext.view(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) as? MovieViewController,
            let toView = toViewController.view
        else {
                return
        }
        
        containerView.addSubview(toView)
        
        var startingFrame = originCell.imageView.frame
        startingFrame.origin = fromView.convert(originCell.frame.origin, to: containerView)
        
        let imageToAnimate = UIImageView(image: originCell.imageView.screenshot)
        imageToAnimate.frame = startingFrame

        toView.frame = originCell.frame
        toView.layoutIfNeeded()
        
        for view in toView.subviews {
            if !(view is UIImageView) {
                view.alpha = isPresenting ? 0.0 : 1.0
            }
        }

        
        containerView.addSubview(imageToAnimate)
        
        UIView.animate(withDuration: duration, animations: { () -> Void in
            let viewControllerDestinationFrame = transitionContext.finalFrame(for: toViewController)
            var imageDestinationFrame = toViewController.posterImageView.frame
            
            //FIXME: using an hardcoded value to fix a wrong navigation bar offset.
            // Please find a better solution
            imageDestinationFrame.origin = CGPoint(x: imageDestinationFrame.origin.x, y: imageDestinationFrame.origin.y + 64)
            imageToAnimate.frame = imageDestinationFrame
            toView.frame = viewControllerDestinationFrame
            
            toView.layoutIfNeeded()
            
            for view in toView.subviews {
                if !(view is UIImageView) {
                    view.alpha = self.isPresenting ? 1.0 : 0.0
                }
            }
        }) { (completed: Bool) -> Void in
            imageToAnimate.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        return
    }
    
    
}


extension UIView {
    var screenshot: UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        if let tableView = self as? UITableView {
            tableView.superview!.layer.render(in: UIGraphicsGetCurrentContext()!)
        } else {
            layer.render(in: UIGraphicsGetCurrentContext()!)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
