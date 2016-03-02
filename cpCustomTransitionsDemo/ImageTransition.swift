//
//  FadeTransition.swift
//  transitionDemo
//
//  Created by Timothy Lee on 11/4/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ImageTransition: BaseTransition {
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        toViewController.view.alpha = 0

        let newsFeedViewController = fromViewController as! NewsFeedViewController
        let photoViewController = toViewController as! PhotoViewController
        let destinationImageFrame = photoViewController.imageView.frame
        
        let movingImageView = UIImageView()
        movingImageView.frame = newsFeedViewController.tappedImage.frame
        
        //Subtract the offset from the scrollview in case the user has changed it
        movingImageView.frame.origin.y -= newsFeedViewController.scrollView.contentOffset.y
        
        movingImageView.image = newsFeedViewController.tappedImage.image
        movingImageView.clipsToBounds = newsFeedViewController.tappedImage.clipsToBounds
        movingImageView.contentMode = newsFeedViewController.tappedImage.contentMode
        containerView.addSubview(movingImageView)
        
        //Hide the initial and final images
        newsFeedViewController.tappedImage.hidden = true
        photoViewController.imageView.hidden = true

        UIView.animateWithDuration(duration, animations: {
            
            toViewController.view.alpha = 1
            movingImageView.frame = destinationImageFrame
            
            }) { (finished: Bool) -> Void in
                movingImageView.hidden = true
                photoViewController.imageView.hidden = false
                self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let newsFeedViewController = toViewController as! NewsFeedViewController
        let photoViewController = fromViewController as! PhotoViewController
        var destinationImageFrame = newsFeedViewController.tappedImage.frame
        destinationImageFrame.origin.y -= newsFeedViewController.scrollView.contentOffset.y
        
        let movingImageView = UIImageView()
        movingImageView.frame = photoViewController.imageView.frame
        
        movingImageView.image = photoViewController.imageView.image
        movingImageView.clipsToBounds = photoViewController.imageView.clipsToBounds
        movingImageView.contentMode = photoViewController.imageView.contentMode
        containerView.addSubview(movingImageView)
        
        photoViewController.imageView.hidden = true
        newsFeedViewController.tappedImage.hidden = true
        
        UIView.animateWithDuration(duration, animations: {
            
            movingImageView.frame = destinationImageFrame
            fromViewController.view.alpha = 0
            
            }) { (finished: Bool) -> Void in
                movingImageView.hidden = true
                newsFeedViewController.tappedImage.hidden = false
                self.finish()
        }
    }
}
