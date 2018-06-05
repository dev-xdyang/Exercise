//
//  InteractiveTransitionBViewController.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class InteractiveTransitionBViewController: UIViewController {
    private let panDirection: PanDirection = .toRight
    private var panGesture: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(gesture:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func panGestureAction(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began,
            gesture.isMatch(direction: panDirection) {
            dismissButtonPressed(gesture)
        }
    }
    
    @IBAction private func dismissButtonPressed(_ sender: AnyObject) {
        if let panInteriveDelegate = transitioningDelegate as? PushPopNavigationInteractiveTransition {
            panInteriveDelegate.panDirection = panDirection
            if sender.isKind(of: UIPanGestureRecognizer.self) {
                panInteriveDelegate.panGesture = panGesture
            } else {
                panInteriveDelegate.panGesture = nil
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
}
