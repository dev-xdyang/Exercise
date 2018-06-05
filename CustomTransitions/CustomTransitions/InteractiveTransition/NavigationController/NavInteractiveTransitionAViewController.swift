//
//  NavInteractiveTransitionAViewController.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class NavInteractiveTransitionAViewController: UIViewController {
    private var panGesture: UIPanGestureRecognizer!
    var isUseDefaultAnimatorWhenDismissNotInteractive = false
    var isUseDefaultAnimatorWhenPresentNotInteractive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(gesture:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func panGestureAction(gesture: UIPanGestureRecognizer) {
        guard gesture.state == .began,
            gesture.isMatch(direction: .toLeft) else { return }
        presentButtonPressed(gesture)
    }
    
    @IBAction private func presentButtonPressed(_ sender: AnyObject) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavInteractiveTransitionBViewController") else { return }
        let nav = PushPopNavigationController(rootViewController: vc)
        nav.isUseDefaultAnimatorWhenDismissNotInteractive = isUseDefaultAnimatorWhenDismissNotInteractive
        nav.isUseDefaultAnimatorWhenPresentNotInteractive = isUseDefaultAnimatorWhenPresentNotInteractive
        let gesture = sender.isKind(of: UIPanGestureRecognizer.self) ? panGesture : nil
        nav.push(fromViewController: self, panGesture: gesture, animated: true)
    }
}
