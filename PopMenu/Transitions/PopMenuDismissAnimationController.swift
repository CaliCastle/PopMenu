//
//  PopMenuDismissAnimationController.swift
//  PopMenu
//
//  Created by Cali Castle on 4/12/18.
//  Copyright © 2018 Cali Castle. All rights reserved.
//

import UIKit

final public class PopMenuDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    /// The source view's frame.
    private let sourceFrame: CGRect?
    
    /// Initializer with source view's frame.
    init(sourceFrame: CGRect?) {
        self.sourceFrame = sourceFrame
    }
    
    /// Duration of the transition.
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.0982
    }
    
    /// Animate PopMenuViewController custom transition.
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let menuViewController = transitionContext.viewController(forKey: .from) as? PopMenuViewController else { return }
        
        let containerView = transitionContext.containerView
        let view = menuViewController.view!
        view.frame = containerView.frame
        containerView.addSubview(view)
        
        let animationDuration = transitionDuration(using: transitionContext)
        let animations = {
            self.animate(menuViewController)
        }
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: animations) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    /// Run the animation.
    fileprivate func animate(_ viewController: PopMenuViewController) {
        viewController.containerView.alpha = 0
        viewController.backgroundView.alpha = 0
        
        viewController.containerView.transform = .init(scaleX: 0.55, y: 0.55)
    }
    
}
