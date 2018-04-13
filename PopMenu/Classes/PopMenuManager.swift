//
//  PopMenuManager.swift
//  PopMenu
//
//  Created by Cali Castle on 4/12/18.
//  Copyright © 2018 Cali Castle. All rights reserved.
//

import UIKit

/// The object responsible for managing a pop menu `PopMenuViewController`
final public class PopMenuManager: NSObject {
    
    /// Default manager singleton.
    public static let `default` = PopMenuManager()
    
    /// Reference to the pop menu view controller.
    private var popMenu: PopMenuViewController!
    
    /// Configure and load pop menu view controller.
    private func prepareViewController(sourceFrame: CGRect?) {
        popMenu = PopMenuViewController(sourceFrame: sourceFrame)
    }
    
}

// MARK: - Presentations

extension PopMenuManager {
    
    public func present(sourceFrame: CGRect? = nil, above: UIViewController? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        prepareViewController(sourceFrame: sourceFrame)
        
        guard let popMenu = popMenu else { print("Pop Menu has not been initialized yet."); return }
        
        if let presentOn = above {
            presentOn.present(popMenu, animated: animated, completion: completion)
        } else {
            if let topViewController = PopMenuManager.getTopViewControllerInWindow() {
                topViewController.present(popMenu, animated: animated, completion: completion)
            }
        }
    }
    
}

extension PopMenuManager {
    
    /// Get top view controller in window.
    fileprivate class func getTopViewControllerInWindow() -> UIViewController? {
        guard let window = UIApplication.shared.keyWindow else { return nil }
        
        return topViewControllerWithRootViewController(rootViewController: window.rootViewController)
    }
    
    /// Get top view controller.
    fileprivate static func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController! {
        // Tab Bar View Controller
        if rootViewController is UITabBarController {
            let tabbarController =  rootViewController as! UITabBarController
            
            return topViewControllerWithRootViewController(rootViewController: tabbarController.selectedViewController)
        }
        // Navigation ViewController
        if rootViewController is UINavigationController {
            let navigationController = rootViewController as! UINavigationController
            
            return topViewControllerWithRootViewController(rootViewController: navigationController.visibleViewController)
        }
        // Presented View Controller
        if let controller = rootViewController.presentedViewController {
            return topViewControllerWithRootViewController(rootViewController: controller)
        } else {
            return rootViewController
        }
    }
    
}
