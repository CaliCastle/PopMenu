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
            let manager = PopMenuManager.default
            
            manager.popMenuAppearance.popMenuFont = UIFont(name: "AvenirNext-DemiBold", size: 16)!
            manager.popMenuDelegate = self
            
            manager.actions = [
                PopMenuDefaultAction(title: "Save to List", image: #imageLiteral(resourceName: "Plus"), color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
                PopMenuDefaultAction(title: "Favorite", image: #imageLiteral(resourceName: "Heart"), color: #colorLiteral(red: 1, green: 0.483630836, blue: 0.4260249734, alpha: 1)),
                PopMenuDefaultAction(title: "Add to Cart", image: #imageLiteral(resourceName: "Cart_Add")),
                PopMenuDefaultAction(title: "Download", image: #imageLiteral(resourceName: "Download"))
            ]
            
            manager.present(sourceFrame: button.frame)
        }
    }

}

extension ViewController: PopMenuViewControllerDelegate {
    
    func popMenuDidSelectItem(at index: Int) {
        print("Item selected at \(index)")
    }
    
}
