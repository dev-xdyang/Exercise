//
//  InteractiveTransitionAViewController.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class InteractiveTransitionAViewController: UIViewController {
    let panDirection: Direction = .toLeft
    let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(gesture:)))
    let panInteriveDelegate = PanInterativeDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func panGestureAction(gesture: UIPanGestureRecognizer) {
        
    }
    
    @IBAction func presentButtonPressed(_ sender: AnyObject) {
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
