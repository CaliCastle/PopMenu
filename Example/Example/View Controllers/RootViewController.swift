//
//  RootViewController.swift
//  Example
//
//  Created by Cali Castle on 4/12/18.
//  Copyright © 2018 Cali Castle. All rights reserved.
//

import UIKit
import PopMenu

class RootViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func presentMenu(_ sender: Any) {
        showMenu(for: sender)
    }

    fileprivate func showMenu(for view: Any) {
        let manager = PopMenuManager.default
        
        manager.popMenuAppearance.popMenuFont = UIFont(name: "AvenirNext-DemiBold", size: 16)!
        manager.popMenuAppearance.popMenuBackgroundStyle = .blurred(.dark)
        manager.popMenuDelegate = self
        
        manager.actions = [
            PopMenuDefaultAction(title: "Save to List", image: #imageLiteral(resourceName: "Plus")),
            PopMenuDefaultAction(title: "Favorite", image: #imageLiteral(resourceName: "Heart")),
            PopMenuDefaultAction(title: "Add to Cart", image: #imageLiteral(resourceName: "Cart_Add")),
            PopMenuDefaultAction(title: "Download", image: #imageLiteral(resourceName: "Download"))
        ]
        
        if let barButton = view as? UIBarButtonItem, let buttonView = barButton.value(forKey: "view") as? UIView {
            manager.present(sourceFrame: buttonView.convert(buttonView.bounds, to: nil), on: self)
        }
        
        if let view = view as? UIView {
            manager.present(sourceFrame: view.frame, on: self)
        }
    }
    
}

extension RootViewController: PopMenuViewControllerDelegate {
    
    func popMenuDidSelectItem(at index: Int) {
        print("Item selected at \(index)")
    }
    
}
