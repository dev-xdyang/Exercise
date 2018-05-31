//
//  NavInteractiveTransitionAViewController.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class NavInteractiveTransitionAViewController: UIViewController {
    private let panDirection: Direction = .toLeft
    private var panGesture: UIPanGestureRecognizer!
    private let panInteriveDelegate = PanInterativeDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(gesture:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func panGestureAction(gesture: UIPanGestureRecognizer) {
        guard gesture.state == .began,
            gesture.isMatch(direction: panDirection) else { return }
        presentButtonPressed(gesture)
    }
    
    @IBAction private func presentButtonPressed(_ sender: AnyObject) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavInteractiveTransitionBViewController") else { return }
        let nav = PushPopInteractiveTransitionNavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.transitioningDelegate = panInteriveDelegate
        panInteriveDelegate.panDirection = panDirection
        if sender.isKind(of: UIPanGestureRecognizer.self) {
            panInteriveDelegate.panGesture = panGesture
        } else {
            panInteriveDelegate.panGesture = nil
        }
        
        present(nav, animated: true, completion: nil)
    }
}
