//
//  NavInteractiveTransitionBViewController.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class NavInteractiveTransitionBViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        if let nav = navigationController as? PushPopInteractiveTransitionNavigationController {
            nav.bindInteractiveVC(controller: self)
        }
    }
    
    @IBAction private func dismissButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
