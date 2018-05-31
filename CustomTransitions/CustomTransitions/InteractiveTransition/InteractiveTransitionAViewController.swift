//
//  InteractiveTransitionAViewController.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class InteractiveTransitionAViewController: UIViewController {
    private let panDirection: Direction = .toLeft
    private var panGesture: UIPanGestureRecognizer!
    private let panInteriveDelegate = PanInterativeDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(gesture:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func panGestureAction(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began,
            gesture.isMatch(direction: panDirection) {
            presentButtonPressed(gesture)
        }
    }
    
    @IBAction private func presentButtonPressed(_ sender: AnyObject) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "InteractiveTransitionBViewController") else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.transitioningDelegate = panInteriveDelegate
        panInteriveDelegate.panDirection = panDirection
        if sender.isKind(of: UIPanGestureRecognizer.self) {
            panInteriveDelegate.panGesture = panGesture
        } else {
            panInteriveDelegate.panGesture = nil
        }
        
        present(vc, animated: true, completion: nil)
    }
}
