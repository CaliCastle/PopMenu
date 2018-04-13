//
//  PopMenuViewController.swift
//  PopMenu
//
//  Created by Cali Castle on 4/12/18.
//  Copyright © 2018 Cali Castle. All rights reserved.
//

import UIKit

public protocol PopMenuViewControllerDelegate: class {
    
}

final public class PopMenuViewController: UIViewController {
    
    public weak var delegate: PopMenuViewControllerDelegate?
    public var appearance = PopMenuAppearance()
    public let contentView = PopMenuGradientView()
    public let actionsView = UIStackView()
    
    fileprivate var sourceFrame: CGRect?
    
    fileprivate lazy var tapGestureForDismissal: UITapGestureRecognizer = {
        let tapper = UITapGestureRecognizer(target: self, action: #selector(bottomViewDidTap(_:)))
        tapper.cancelsTouchesInView = false
        tapper.delaysTouchesEnded = false
        tapper.delegate = self
        
        return tapper
    }()
    
    // MARK: - View Life Cycle
    
    convenience init(sourceFrame: CGRect? = nil, appearance: PopMenuAppearance? = nil) {
        self.init(nibName: nil, bundle: nil)
        
        self.sourceFrame = sourceFrame

        // Assign appearance or use the default one.
        if let appearance = appearance {
            self.appearance = appearance
        }

        transitioningDelegate = self
        modalPresentationStyle = .overFullScreen
        modalPresentationCapturesStatusBarAppearance = true
    }
    
    public override func loadView() {
        super.loadView()
        
        // Check if is full screen size
        let screenBounds = UIScreen.main.bounds
        if !view.frame.equalTo(screenBounds) { view.frame = screenBounds }
        
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        // view.backgroundColor = .clear
        view.backgroundColor = UIColor.black.withAlphaComponent(0.45) // TO BE DELETED
        
        view.addGestureRecognizer(tapGestureForDismissal)
        
        configureContentView()
        configureActionsView()
    }
    
    public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

// MARK: - View Configurations

extension PopMenuViewController {
    
    fileprivate func configureContentView() {
        contentView.accessibilityViewIsModal = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = 24
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        
        let colors = appearance.popMenuColor.colors
        if colors.count > 0 {
            if colors.count == 1 {
                contentView.backgroundColor = colors.first
            } else {
                contentView.diagonalMode = true
                contentView.startColor = colors.first!
                contentView.endColor = colors.last!
            }
        }
        
        view.addSubview(contentView)
        
        /// Temporary
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            contentView.widthAnchor.constraint(equalToConstant: 240),
            contentView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    fileprivate func configureActionsView() {
        let topAction = UIButton(type: .custom)
        topAction.setTitle("Button 1", for: .normal)
        
        let bottomAction = UIButton(type: .custom)
        bottomAction.setTitle("Button 2", for: .normal)
        
        actionsView.translatesAutoresizingMaskIntoConstraints = false
        actionsView.axis = .vertical
        actionsView.alignment = .center
        actionsView.distribution = .fillEqually
        
        actionsView.addArrangedSubview(topAction)
        actionsView.addArrangedSubview(bottomAction)
        
        contentView.addSubview(actionsView)
        
        NSLayoutConstraint.activate([
            actionsView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            actionsView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            actionsView.topAnchor.constraint(equalTo: contentView.topAnchor),
            actionsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}

// MARK: - Gestures Control

extension PopMenuViewController: UIGestureRecognizerDelegate {

    @objc fileprivate func bottomViewDidTap(_ gesture: UIGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let contentTouched = touch.view?.isDescendant(of: contentView) else { return true }
        
        return !contentTouched
    }
    
}

extension PopMenuViewController: UIViewControllerTransitioningDelegate {
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        //        return PopMenuPresentAnimationController()
        return nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        //        return PopMenuDismissAnimationController()
        return nil
    }
    
}
