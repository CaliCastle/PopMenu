//
//  ViewController.swift
//  Example
//
//  Created by Cali Castle on 4/12/18.
//  Copyright © 2018 Cali Castle. All rights reserved.
//

import UIKit
import PopMenu

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func present(_ sender: Any) {
        if let button = sender as? UIButton {
            PopMenuManager.default.popMenuAppearance.popMenuFont = UIFont(name: "AvenirNext-DemiBold", size: 15)!
            PopMenuManager.default.popMenuDelegate = self
            PopMenuManager.default.present(sourceFrame: button.frame)
        }
    }

}

extension ViewController: PopMenuViewControllerDelegate {
    
    func popMenuDidSelectItem(at index: Int) {
        print("Item selected at \(index)")
    }
    
}
