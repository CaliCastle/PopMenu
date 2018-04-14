//
//  PopMenuViewController.swift
//  PopMenu
//
//  Created by Cali Castle on 4/12/18.
//  Copyright © 2018 Cali Castle. All rights reserved.
//

import UIKit

@objc public protocol PopMenuViewControllerDelegate: class {
    @objc optional func popMenuDidSelectItem(at index: Int)
}

final public class PopMenuViewController: UIViewController {
    
    public weak var delegate: PopMenuViewControllerDelegate?
    public var appearance = PopMenuAppearance()
    
    private let backgroundView = UIView()
    
    /// The blur overlay view for translucent illusion.
    private lazy var blurOverlayView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = appearance.popMenuCornerRadius
        blurView.layer.masksToBounds = true
        
        return blurView
    }()
    
    /// Main content view.
    public let contentView = PopMenuGradientView()
    
    /// The view contains all the actions.
    public let actionsView = UIStackView()
    
    fileprivate var sourceFrame: CGRect?
    
    fileprivate lazy var tapGestureForDismissal: UITapGestureRecognizer = {
        let tapper = UITapGestureRecognizer(target: self, action: #selector(backgroundViewDidTap(_:)))
        tapper.delaysTouchesEnded = false
        
        return tapper
    }()
    
    public private(set) var actions: [PopMenuAction] = []
    
    // MARK: - View Life Cycle
    
    convenience init(sourceFrame: CGRect? = nil, actions: [PopMenuAction], appearance: PopMenuAppearance? = nil) {
        self.init(nibName: nil, bundle: nil)
        
        self.sourceFrame = sourceFrame
        self.actions = actions

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
        view.backgroundColor = .clear // TO BE DELETED
        
        configureBackgroundView()
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
    
    fileprivate func configureBackgroundView() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addGestureRecognizer(tapGestureForDismissal)
        
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        view.addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    fileprivate func configureContentView() {
        contentView.accessibilityViewIsModal = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = appearance.popMenuCornerRadius
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        
        let colors = appearance.popMenuColor.backgroundColor.colors
        if colors.count > 0 {
            if colors.count == 1 {
                contentView.backgroundColor = colors.first?.withAlphaComponent(0.8)
            } else {
                contentView.diagonalMode = true
                contentView.startColor = colors.first!
                contentView.endColor = colors.last!
                contentView.gradientLayer.opacity = 0.8
            }
        }
        
        view.addSubview(blurOverlayView)
        view.addSubview(contentView)
        
        /// Temporary
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            contentView.widthAnchor.constraint(equalToConstant: 240),
            contentView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            blurOverlayView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            blurOverlayView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            blurOverlayView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blurOverlayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    fileprivate func configureActionsView() {
        actionsView.translatesAutoresizingMaskIntoConstraints = false
        actionsView.axis = .vertical
        actionsView.alignment = .fill
        actionsView.distribution = .fillEqually
        
        actions.forEach {
            $0.font = self.appearance.popMenuFont
            $0.textColor = self.appearance.popMenuColor.actionColor.color
            $0.renderActionView()
            
            actionsView.addArrangedSubview($0.view)
            
            let tapper = UITapGestureRecognizer(target: self, action: #selector(menuDidTap))
            tapper.delaysTouchesEnded = false
            
            $0.view.addGestureRecognizer(tapper)
        }
        
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

    /// Once the background view is tapped (for dismissal).
    @objc fileprivate func backgroundViewDidTap(_ gesture: UIGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    /// When the menu action gets tapped
    @objc fileprivate func menuDidTap(_ gesture: UITapGestureRecognizer) {
        guard let attachedView = gesture.view, let index = actions.index(where: { $0.view.isEqual(attachedView) }) else { return }
       
        delegate?.popMenuDidSelectItem?(at: index)
    }
    
}

// MARK: - Transitioning Delegate

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
