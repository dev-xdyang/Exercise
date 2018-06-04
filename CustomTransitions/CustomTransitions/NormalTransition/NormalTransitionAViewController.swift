//
//  NormalTransitionAViewController.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class NormalTransitionAViewController: UIViewController {
    // MARK: - Public
    var presentingAnimatorType: AnimatorType = .dissolve
    var dismissAnimatorType: AnimatorType = .dissolve
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Action
extension NormalTransitionAViewController {
    @IBAction func presentButtonPressed(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "NormalTransitionBViewController") else { return }
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
    }
}

extension NormalTransitionAViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch presentingAnimatorType {
        case .dissolve:
            return DissolveTransitionAnimator()
        case .halfWaySpring:
            return HalfWaySpringTransitionAnimator()
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch dismissAnimatorType {
        case .dissolve:
            return DissolveTransitionAnimator()
        case .halfWaySpring:
            return HalfWaySpringTransitionAnimator()
        }
    }
}
