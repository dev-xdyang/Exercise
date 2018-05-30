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
    
    private let itemList = ["dissolve", "half way spring", "present: half way spring; dismiss: dissolve"]
    
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
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < itemList.count else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        cell.listLabel.text = itemList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.row < itemList.count else { return }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "NormalTransitionAViewController") as? NormalTransitionAViewController else { return }
        switch indexPath.row {
        case 0:
            vc.presentingAnimatorType = .dissolve
            vc.dismissAnimatorType = .dissolve
        case 1:
            vc.presentingAnimatorType = .halfWaySpring
            vc.dismissAnimatorType = .halfWaySpring
        case 2:
            vc.presentingAnimatorType = .halfWaySpring
            vc.dismissAnimatorType = .dissolve
        default:
            break
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

