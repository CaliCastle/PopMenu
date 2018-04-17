//
//  PopMenuPresentAnimationController.swift
//  PopMenu
//
//  Created by Cali Castle on 4/12/18.
//  Copyright © 2018 Cali Castle. All rights reserved.
//

import UIKit

final public class PopMenuPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    /// Source view's frame.
    private let sourceFrame: CGRect?
    
    /// Initializer with source view's frame.
    init(sourceFrame: CGRect?) {
        self.sourceFrame = sourceFrame
    }
    
    /// Duration of the transition.
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.138
    }
    
    /// Animate PopMenuViewController custom transition.
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let menuViewController = transitionContext.viewController(forKey: .to) as? PopMenuViewController else { return }
        
        let containerView = transitionContext.containerView
        let view = menuViewController.view!
        view.frame = containerView.frame
        containerView.addSubview(view)
        
        prepareAnimation(menuViewController)
        
        let animationDuration = transitionDuration(using: transitionContext)
        let animations = {
            self.animate(menuViewController)
        }
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: animations) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    /// States before animation.
    fileprivate func prepareAnimation(_ viewController: PopMenuViewController) {
        viewController.containerView.alpha = 0
        viewController.backgroundView.alpha = 0
        
        if let sourceFrame = sourceFrame {
            viewController.contentLeftConstraint.constant = sourceFrame.origin.x
            viewController.contentTopConstraint.constant = sourceFrame.origin.y
            viewController.contentWidthConstraint.constant = sourceFrame.size.width
            viewController.contentHeightConstraint.constant = sourceFrame.size.height
        }
    }
    
    /// Run the animation.
    fileprivate func animate(_ viewController: PopMenuViewController) {
        viewController.containerView.alpha = 1
        viewController.backgroundView.alpha = 1
        
        let contentFrame = viewController.contentFrame
        viewController.contentLeftConstraint.constant = contentFrame.origin.x
        viewController.contentTopConstraint.constant = contentFrame.origin.y
        viewController.contentWidthConstraint.constant = contentFrame.size.width
        viewController.contentHeightConstraint.constant = contentFrame.size.height
        
        viewController.containerView.layoutIfNeeded()
    }
    
}
