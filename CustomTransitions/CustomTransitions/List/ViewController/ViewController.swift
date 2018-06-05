//
//  ViewController.swift
//  CustomTransitions
//
//  Created by yang on 2018/5/30.
//  Copyright © 2018 yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let itemList = ["dissolve",
                            "half way spring",
                            "present: half way spring; dismiss: dissolve",
                            "interative: Swipe -> ViewController",
                            "interative: Swipe -> UINavigationController",
                            " swipe present: push animator \n not interative present: push animator \n swipe dismiss: pop animator \n not interative dismiss: default animator",
                            " swipe present: push animator \n not interative present: default animator \n swipe dismiss: pop animator \n not interative dismiss: default animator"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 5 || indexPath.row == 6 {
            return 100
        }
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < itemList.count else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        cell.listLabel.numberOfLines = 0
        cell.listLabel.text = itemList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        func normalViewController() -> NormalTransitionAViewController? {
            return self.storyboard?.instantiateViewController(withIdentifier: "NormalTransitionAViewController") as? NormalTransitionAViewController
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.row < itemList.count else { return }
        var vc: UIViewController? = nil
        switch indexPath.row {
        case 0:
            let normalVC = normalViewController()
            normalVC?.presentingAnimatorType = .dissolve
            normalVC?.dismissAnimatorType = .dissolve
            vc = normalVC
        case 1:
            let normalVC = normalViewController()
            normalVC?.presentingAnimatorType = .halfWaySpring
            normalVC?.dismissAnimatorType = .halfWaySpring
            vc = normalVC
        case 2:
            let normalVC = normalViewController()
            normalVC?.presentingAnimatorType = .halfWaySpring
            normalVC?.dismissAnimatorType = .dissolve
            vc = normalVC
        case 3:
            vc = self.storyboard?.instantiateViewController(withIdentifier: "InteractiveTransitionAViewController") as? InteractiveTransitionAViewController
        case 4:
            vc = self.storyboard?.instantiateViewController(withIdentifier: "NavInteractiveTransitionAViewController") as? NavInteractiveTransitionAViewController
        case 5:
            let tmpVC = self.storyboard?.instantiateViewController(withIdentifier: "NavInteractiveTransitionAViewController") as? NavInteractiveTransitionAViewController
            tmpVC?.isUseDefaultAnimatorWhenDismissNotInteractive = true
            vc = tmpVC
        case 6:
            let tmpVC = self.storyboard?.instantiateViewController(withIdentifier: "NavInteractiveTransitionAViewController") as? NavInteractiveTransitionAViewController
            tmpVC?.isUseDefaultAnimatorWhenDismissNotInteractive = true
            tmpVC?.isUseDefaultAnimatorWhenPresentNotInteractive = true
            vc = tmpVC
        default:
            break
        }
        if let gotoVC = vc {
            navigationController?.pushViewController(gotoVC, animated: true)
        }
    }
}

