//
//  PhotoViewController.swift
//  Facebook
//
//  Created by Anthony Devincenzi on 3/1/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImageView!
    var targetOriginalCenter: CGPoint!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var imageTransition: ImageTransition!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image.image
        scrollView.delegate = self
        
        scrollView.contentSize = CGSizeMake(1600, imageView.image!.size.height)
        
        var scrollViewWidth = scrollView.frame.width
        var image2 = UIImageView(frame: CGRectMake(scrollViewWidth, 0, 320, 400))
        image2.clipsToBounds = true
        image2.contentMode = .ScaleAspectFill
        image2.frame.origin.y = 80
        image2.image = UIImage(named: "wedding1")
        
        //scrollView.addSubview(image2)
        
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
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.doneButton.alpha = 0
            })
        } else if sender.state == UIGestureRecognizerState.Changed {
            imageView.center = CGPoint(x: targetOriginalCenter.x + translation.x, y: targetOriginalCenter.y + translation.y)

            if translation.y > 0 {
                view.backgroundColor = UIColor(white: 0, alpha: (50 / translation.y))
            } else if translation.y < 0 {
                view.backgroundColor = UIColor(white: 0, alpha: (50 / translation.y * -1))

            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.doneButton.alpha = 1
            })
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
