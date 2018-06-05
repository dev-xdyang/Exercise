//
//  PushPopNavigationController.swift
//  CustomTransitions
//  description: 切换行为同push/pop、可交互的NavigationController
//  Created by yang on 2018/5/31.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

// MARK: - Public
extension PushPopNavigationController {
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
    
    public func addDismissPanGestureTo(controller: UIViewController) {
        let dismissPanGesture = UIPanGestureRecognizer(target: self, action: #selector(dismissPanGestureAction(gesture:)))
        dismissPanGesture.delegate = self
        controller.view?.addGestureRecognizer(dismissPanGesture)
        self.panGesture = dismissPanGesture
    }
}

public class PushPopNavigationController: UINavigationController {
    /// 不是交互dimiss的时候，是否使用系统默认的动画； 默认是false
    public var isUseDefaultAnimatorWhenDismissNotInteractive = false {
        didSet {
            panInteriveDelegate.isUseDefaultAnimatorWhenDismissNotInteractive = isUseDefaultAnimatorWhenDismissNotInteractive
        }
    }
    
    /// 不是交互present的时候，是否使用系统默认的动画, 要让改设置项有效在调用push函数时传入的panGesture需要为nil; 默认是false
    public var isUseDefaultAnimatorWhenPresentNotInteractive = false {
        didSet {
            panInteriveDelegate.isUseDefaultAnimatorWhenPresentNotInteractive = isUseDefaultAnimatorWhenPresentNotInteractive
        }
    }
    
    public init(rootViewController: UIViewController,
                pushDirection: PanDirection = .toLeft) {
        self.rootVC = rootViewController
        super.init(rootViewController: rootViewController)
        modalPresentationStyle = .fullScreen
        transitioningDelegate = panInteriveDelegate
        self.pushDirection = pushDirection
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.rootVC = UIViewController()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private let panInteriveDelegate = PushPopNavigationInteractiveTransition()
    private var pushDirection: PanDirection = .toLeft
    private var panGesture: UIPanGestureRecognizer?
    private let rootVC: UIViewController
}

extension PushPopNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let pan = gestureRecognizer as? UIPanGestureRecognizer,
            pan == panGesture {
            return pan.isMatch(direction: pushDirection.toggle)
        }
        
        return true
    }
    
    @objc private func dismissPanGestureAction(gesture: UIPanGestureRecognizer) {
        let panDirection = pushDirection.toggle
        guard gesture.state == .began,
            gesture.isMatch(direction: panDirection),
            let panInteriveDelegate = transitioningDelegate as? PushPopNavigationInteractiveTransition else { return }
        panInteriveDelegate.panDirection = panDirection
        panInteriveDelegate.panGesture = panGesture
        
        dismiss(animated: true) { [weak self] in
            self?.panInteriveDelegate.panGesture = nil
        }
    }
}
