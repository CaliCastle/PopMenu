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
    
    // MARK: - Properties
    
    /// Default manager singleton.
    public static let `default` = PopMenuManager()
    
    /// Reference to the pop menu view controller.
    private var popMenu: PopMenuViewController!
    
    /// Reference to the pop menu delegate instance.
    public weak var popMenuDelegate: PopMenuViewControllerDelegate? {
        didSet {
            popMenu?.delegate = popMenuDelegate
        }
    }
    
    /// Determines whether to dismiss menu after an action is selected.
    public var popMenuShouldDismissOnSelection: Bool = true
    
    /// The dismissal handler for pop menu.
    public var popMenuDidDismiss: ((Bool) -> Void)?
    
    /// Determines whether to use haptics for menu selection.
    public var popMenuShouldEnableHaptics: Bool = true
    
    /// Appearance for passing on to pop menu.
    public let popMenuAppearance: PopMenuAppearance
    
    /// Every action item about to be displayed.
    public var actions: [PopMenuAction] = []
    
    // MARK: - Important Methods
    
    /// Configure and load pop menu view controller.
    private func prepareViewController(sourceView: AnyObject?) {
        popMenu = PopMenuViewController(sourceView: sourceView, actions: actions)

        popMenu.delegate = popMenuDelegate
        popMenu.appearance = popMenuAppearance
        popMenu.shouldDismissOnSelection = popMenuShouldDismissOnSelection
        popMenu.didDismiss = popMenuDidDismiss
        popMenu.shouldEnableHaptics = popMenuShouldEnableHaptics
    }
    
    /// Initializer with appearance.
    public init(appearance: PopMenuAppearance = PopMenuAppearance()) {
        popMenuAppearance = appearance
    }
    
    /// Pass a new action to pop menu.
    public func addAction(_ action: PopMenuAction) {
        if let popMenu = popMenu {
            popMenu.addAction(action)
        } else {
            actions.append(action)
        }
    }
    
}

// MARK: - Presentations

extension PopMenuManager {
    
    /// Present the pop menu.
    ///
    /// - Parameters:
    ///   - sourceView: From which view and where exactly on the screen to be shown
    ///     (default: show in the center)
    ///
    ///   - above: Present above which controller
    ///     (default: use the top view controller)
    ///
    ///   - animated: Animate the presentation
    ///   - completion: Completion handler
    public func present(sourceView: AnyObject? = nil, on viewController: UIViewController? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        prepareViewController(sourceView: sourceView)
        
        guard let popMenu = popMenu else { print("Pop Menu has not been initialized yet."); return }
        
        if let presentOn = viewController {
            presentOn.present(popMenu, animated: animated, completion: completion)
        } else {
            if let topViewController = PopMenuManager.getTopViewControllerInWindow() {
                topViewController.present(popMenu, animated: animated, completion: completion)
            }
        }
    }
    
}

// MARK: - Helper Methods

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
