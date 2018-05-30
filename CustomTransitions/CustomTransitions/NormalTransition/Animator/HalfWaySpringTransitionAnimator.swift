//
//  HalfWaySpringTransitionAnimator.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class HalfWaySpringTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        let isPresenting = toVC.presentingViewController == fromVC
        
        if isPresenting {
            containerView.addSubview(toView)
            
            fromView.frame = transitionContext.initialFrame(for: fromVC)
            let toViewFrame = transitionContext.finalFrame(for: toVC)
            toView.frame = CGRect(x: toViewFrame.minX,
                                  y: toViewFrame.height / 2,
                                  width: toViewFrame.width,
                                  height: toViewFrame.height)
            toView.alpha = 0
            
            UIView.animate(withDuration: duration, animations: {
                toView.frame = toViewFrame
                toView.alpha = 1
            }) { _ in
                let canceled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!canceled)
            }
        } else {
            containerView.insertSubview(toView, belowSubview: fromView)
            
            toView.frame = transitionContext.finalFrame(for: toVC)
            let fromViewFrame = transitionContext.initialFrame(for: fromVC)
            fromView.frame = fromViewFrame
            
            UIView.animate(withDuration: duration, animations: {
                fromView.alpha = 0
                fromView.frame = CGRect(x: fromViewFrame.minX,
                                        y: fromViewFrame.height / 2,
                                        width: fromViewFrame.width,
                                        height: fromViewFrame.height)
            }) { _ in
                let canceled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!canceled)
            }
        }
    }
}
