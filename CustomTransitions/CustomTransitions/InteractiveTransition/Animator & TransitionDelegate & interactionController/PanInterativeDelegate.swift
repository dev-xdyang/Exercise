//
//  PanInterativeDelegate.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class PanInterativeDelegate: NSObject, UIViewControllerTransitioningDelegate {
    var panDirection: Direction = .toLeft
    var panGesture: UIPanGestureRecognizer?
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushPopAnimator(direction: panDirection)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushPopAnimator(direction: panDirection)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gesture = panGesture {
            return PanInterativeController(panDirection: panDirection, panGesture: gesture)
        } else {
            return nil
        }
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gesture = panGesture {
            return PanInterativeController(panDirection: panDirection, panGesture: gesture)
        } else {
            return nil
        }
    }
}
