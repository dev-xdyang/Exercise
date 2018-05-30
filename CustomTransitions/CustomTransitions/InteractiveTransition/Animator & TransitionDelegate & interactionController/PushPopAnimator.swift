//
//  PushPopAnimator.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class PushPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        let isPresenting = toVC.presentingViewController == fromVC
        let fromVCFrame = transitionContext.initialFrame(for: fromVC)
        let toVCFrame = transitionContext.finalFrame(for: toVC)
        
        let offset: CGVector
        switch direction {
        case .toLeft:
            offset = CGVector(dx: 1, dy: 0)
        case .toRight:
            offset = CGVector(dx: -1, dy: 0)
        case .toTop:
            offset = CGVector(dx: 0, dy: 1)
        case .toBottom:
            offset = CGVector(dx: 0, dy: -1)
        }
        
        if isPresenting {
            fromView.frame = fromVCFrame
            toView.frame = toVCFrame.offsetBy(dx: toVCFrame.width * offset.dx + offset.dx,
                                              dy: toVCFrame.height * offset.dy + offset.dy)
            containerView.addSubview(toView)
        } else {
            fromView.frame = fromVCFrame
            toView.frame = toVCFrame
            containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        UIView.animate(withDuration: duration, animations: {
            if isPresenting {
                toView.frame = toVCFrame
            } else {
                fromView.frame = fromVCFrame.offsetBy(dx: -(fromVCFrame.width * offset.dx + offset.dx),
                                                    dy: -(fromVCFrame.height * offset.dy + offset.dy))
            }
        }) { _ in
            let canceled = transitionContext.transitionWasCancelled
            if canceled {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(!canceled)
        }
    }
}
