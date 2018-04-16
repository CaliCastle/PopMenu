//
//  NavigationController.swift
//  Example
//
//  Created by Cali Castle on 4/15/18.
//  Copyright © 2018 Cali Castle. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Remove navigation bar border line
        navigationBar.shadowImage = UIImage()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
