//
//  InteractiveTransitionBViewController.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class InteractiveTransitionBViewController: UIViewController {
    let panDirection: Direction = .toRight
    let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(gesture:)))
    
    @objc func panGestureAction(gesture: UIPanGestureRecognizer) {
        
    }
    
    @IBAction func dismissButtonPressed(_ sender: AnyObject) {
        if let panInteriveDelegate = transitioningDelegate as? PanInterativeDelegate {
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
