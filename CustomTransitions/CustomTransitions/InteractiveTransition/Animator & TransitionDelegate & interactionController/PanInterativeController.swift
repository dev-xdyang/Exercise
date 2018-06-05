//
//  PanInterativeController.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class PanInterativeController: UIPercentDrivenInteractiveTransition {
    private var transitionContext: UIViewControllerContextTransitioning?
    private let panDirection: PanDirection
    private let panGesture: UIPanGestureRecognizer
    
    init(panDirection: PanDirection,
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
            let view = transitionContext?.containerView == nil ? transitionContext?.containerView : gesture.view
            let velocity = gesture.velocity(in: view)
            let percentValue = percent(gesture: gesture, velocity: velocity)
            if percentValue > 0.5 {
                finish()
            } else {
                cancel()
            }
        default:
            cancel()
        }
    }
    
    private func percent(gesture: UIPanGestureRecognizer, velocity: CGPoint) -> CGFloat {
        var translation: CGPoint = .zero
        
        var width = gesture.view?.frame.width ?? UIScreen.main.bounds.width
        var height = gesture.view?.frame.height ?? UIScreen.main.bounds.height
        if let context = transitionContext {
            let containerView = context.containerView
            translation = gesture.translation(in: containerView)
            
            width = containerView.frame.width
            height = containerView.frame.height
        }
        
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
