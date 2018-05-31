//
//  PushPopInteractiveTransitionNavigationController.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/31.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

// MARK: - Public
extension PushPopInteractiveTransitionNavigationController {
    public func push(fromViewController: UIViewController,
                     panGesture: UIPanGestureRecognizer?,
                     animated flag: Bool,
                     completion: (() -> Swift.Void)? = nil) {
        panInteriveDelegate.panDirection = pushDirection
        panInteriveDelegate.panGesture = panGesture
        
        fromViewController.present(self, animated: flag) { [weak self] in
            guard let _s = self else { return }
            _s.panInteriveDelegate.panDirection = _s.pushDirection.toggle
            _s.panInteriveDelegate.panGesture = nil
            
            completion?()
        }
    }
    
    public func pop(animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        dismiss(animated: flag, completion: completion)
    }
    
    public func bindInteractiveVC(controller: UIViewController) {
        let dismissPanGesture = UIPanGestureRecognizer(target: self, action: #selector(dismissPanGestureAction(gesture:)))
        controller.view.addGestureRecognizer(dismissPanGesture)
        self.panGesture = dismissPanGesture
    }
}

class PushPopInteractiveTransitionNavigationController: UINavigationController {
    init(rootViewController: UIViewController,
         pushDirection: Direction = .toLeft) {
        self.pushDirection = pushDirection
        super.init(rootViewController: rootViewController)
        modalPresentationStyle = .fullScreen
        transitioningDelegate = panInteriveDelegate
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private let panInteriveDelegate = PanInterativeDelegate()
    private var pushDirection: Direction = .toLeft
    private var panGesture: UIPanGestureRecognizer?
    
    @objc private func dismissPanGestureAction(gesture: UIPanGestureRecognizer) {
        let panDirection = pushDirection.toggle
        guard gesture.state == .began,
            gesture.isMatch(direction: panDirection),
            let panInteriveDelegate = transitioningDelegate as? PanInterativeDelegate else { return }
        panInteriveDelegate.panDirection = panDirection
        panInteriveDelegate.panGesture = panGesture
        
        dismiss(animated: true) { [weak self] in
            self?.panInteriveDelegate.panGesture = nil
        }
    }
}
