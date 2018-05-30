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
    private let panDirection: Direction = .toLeft
    private let panGesture: UIPanGestureRecognize
    
    init(panDirection: Direction,
         panGesture: UIPanGestureRecognizer) {
        self.panGesture = panGesture
        self.panDirection = panDirection
        super.init()
        
        panGesture.addTarget(self, action: #selector(panGestureAction(gesture:)))
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
    }
    
    @objc private func panGestureAction(gesture: UIPanGestureRecognizer) {
        
    }
    
    
}
