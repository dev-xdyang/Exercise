//
//  PushPopInteractiveTransitionNavigationController.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/31.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class PushPopInteractiveTransitionNavigationController: UINavigationController {
    // MARK: - Public
    public func bindInteractiveVC(controller: UIViewController) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(gesture:)))
        controller.view.addGestureRecognizer(panGesture)
        self.panGesture = panGesture
    }
    
    // MARK: - Private
    private let panDirection: Direction = .toRight
    private var panGesture: UIPanGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func panGestureAction(gesture: UIPanGestureRecognizer) {
        guard gesture.state == .began,
            gesture.isMatch(direction: panDirection),
            let panInteriveDelegate = transitioningDelegate as? PanInterativeDelegate else { return }
        panInteriveDelegate.panDirection = panDirection
        panInteriveDelegate.panGesture = panGesture
    }
}
