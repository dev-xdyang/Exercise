//
//  PanInterativeController.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class PanInterativeController: UIPercentDrivenInteractiveTransition  {
    private var transitionContext: UIViewControllerContextTransitioning?
    private let panDirection: Direction
    private let panGesture: UIPanGestureRecognizer
    
    init(panDirection: Direction,
         panGesture: UIPanGestureRecognizer) {
        self.panGesture = panGesture
        self.panDirection = panDirection
        super.init()
        
        panGesture.addTarget(self, action: #selector(panGestureAction(gesture:)))
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        super.startInteractiveTransition(transitionContext)
    }
    
    @objc private func panGestureAction(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            break
        case .changed:
            update(percent(gesture: gesture, velocity: .zero))
        case .ended:
            let velocity = gesture.velocity(in: transitionContext?.containerView)
            if percent(gesture: gesture, velocity: velocity) > 0.5 {
                finish()
            } else {
                cancel()
            }
        default:
            cancel()
        }
    }
    
    private func percent(gesture: UIPanGestureRecognizer, velocity: CGPoint) -> CGFloat {
        guard let context = transitionContext else { return 0 }
        
        let containerView = context.containerView
        let translation = gesture.translation(in: containerView)
        let width = containerView.frame.width
        let height = containerView.frame.height
        guard width > 0, height > 0 else { return 0 }
        
        // using relative moved length to calculate percent
        switch panDirection {
        case .toLeft:
            return abs(min(translation.x + velocity.x, 0)) / width
        case .toRight:
            return abs(max(translation.x + velocity.x, 0)) / width
        case .toTop:
            return abs(min(translation.y + velocity.y, 0)) / height
        case .toBottom:
            return abs(max(translation.y + velocity.y, 0)) / height
        }
    }
}


