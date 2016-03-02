//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Anthony Devincenzi on 3/1/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImageView!
    var targetOriginalCenter: CGPoint!
    
    var imageTransition: ImageTransition!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image.image
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func didPanPhoto(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)

        if sender.state == UIGestureRecognizerState.Began {
            targetOriginalCenter = imageView.center
        } else if sender.state == UIGestureRecognizerState.Changed {
            imageView.center = CGPoint(x: targetOriginalCenter.x + translation.x, y: targetOriginalCenter.y + translation.y)

            if translation.y > 0 {
                view.backgroundColor = UIColor(white: 0, alpha: (50 / translation.y))
            } else if translation.y < 0 {
                view.backgroundColor = UIColor(white: 0, alpha: (50 / translation.y * -1))

            }
            
            print(translation.y)

            
        } else if sender.state == UIGestureRecognizerState.Ended {
            if translation.y > 100 {
                dismissViewControllerAnimated(true, completion: nil)
            } else if translation.y < -100 {
                dismissViewControllerAnimated(true, completion: nil)
            } else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.imageView.center = self.targetOriginalCenter
                    self.view.backgroundColor = UIColor(white: 0, alpha: 1)
                })
            }
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return imageView
    }
}
