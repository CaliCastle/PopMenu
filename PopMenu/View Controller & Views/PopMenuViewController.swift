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
    
    /// Appearance configuration.
    public var appearance = PopMenuAppearance()
    
    /// Background overlay that covers the whole screen.
    private let backgroundView = UIView()
    
    /// The blur overlay view for translucent illusion.
    private lazy var blurOverlayView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = appearance.popMenuCornerRadius
        blurView.layer.masksToBounds = true
        blurView.isUserInteractionEnabled = false
        
        return blurView
    }()
    
    public let containerView = UIView()
    
    /// Main content view.
    public let contentView = PopMenuGradientView()
    
    /// The view contains all the actions.
    public let actionsView = UIStackView()
    
    /// The source frame to be displayed from.
    fileprivate var sourceFrame: CGRect?
    
    /// Tap gesture to dismiss for background view.
    fileprivate lazy var tapGestureForDismissal: UITapGestureRecognizer = {
        let tapper = UITapGestureRecognizer(target: self, action: #selector(backgroundViewDidTap(_:)))
        tapper.cancelsTouchesInView = false
        tapper.delaysTouchesEnded = false
        
        return tapper
    }()
    
    /// Pan gesture to highligh actions.
    fileprivate lazy var panGestureForMenu: UIPanGestureRecognizer = {
        let panner = UIPanGestureRecognizer(target: self, action: #selector(menuDidPan(_:)))
        panner.maximumNumberOfTouches = 1
        
        return panner
    }()
    
    public private(set) var actions: [PopMenuAction] = []
    
    /// Max content width allowed for the content to stretch to.
    fileprivate let maxContentWidth: CGFloat = UIScreen.main.bounds.size.width * 0.9
        
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
    
    /// Load view entry point.
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
    
    /// Setup the background view at the bottom.
    fileprivate func configureBackgroundView() {
        backgroundView.frame = view.frame
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundView.addGestureRecognizer(tapGestureForDismissal)
        backgroundView.isUserInteractionEnabled = true
        
        view.addSubview(backgroundView)
    }
    
    fileprivate func configureContentView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addShadow(offset: .init(width: 0, height: 1), opacity: 0.6, radius: 20)
        containerView.layer.cornerRadius = appearance.popMenuCornerRadius
        containerView.backgroundColor = .clear
        
        view.addSubview(containerView)
        
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

        containerView.addSubview(blurOverlayView)
        containerView.addSubview(contentView)
        
        setupContentConstraints()
    }
    
    fileprivate func setupContentConstraints() {
        let contentFitOrigin = calculateContentOrigin()
        let contentFitWidth = calculateContentWidth()
        
        // Activate container view constraints.
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: contentFitOrigin.x),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: contentFitOrigin.y),
            containerView.widthAnchor.constraint(equalToConstant: contentFitWidth),
            containerView.heightAnchor.constraint(equalToConstant: CGFloat(actions.count) * appearance.popMenuActionHeight)
        ])
        // Activate content view constraints.
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            contentView.topAnchor.constraint(equalTo: containerView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        // Activate blur overlay constraints.
        NSLayoutConstraint.activate([
            blurOverlayView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            blurOverlayView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            blurOverlayView.topAnchor.constraint(equalTo: containerView.topAnchor),
            blurOverlayView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    fileprivate func calculateContentOrigin() -> CGPoint {
        
        
        return .zero
    }
    
    fileprivate func calculateContentWidth() -> CGFloat {
        var contentFitWidth: CGFloat = 0
        contentFitWidth += PopMenuDefaultAction.iconWidthHeight
        contentFitWidth += PopMenuDefaultAction.textLeftPadding * 2
        
        // Calculate the widest width from action titles to determine the width
        if let action = actions.max(by: {
            guard let title1 = $0.title, let title2 = $1.title else { return false }
            return title1.count < title2.count
        }) {
            let sizingLabel = UILabel()
            sizingLabel.text = action.title
            
            let desiredWidth = sizingLabel.sizeThatFits(view.bounds.size).width
            contentFitWidth += min(desiredWidth, maxContentWidth)
        }
        
        return contentFitWidth
    }
    
    fileprivate func configureActionsView() {
        actionsView.addGestureRecognizer(panGestureForMenu)
        
        actionsView.translatesAutoresizingMaskIntoConstraints = false
        actionsView.axis = .vertical
        actionsView.alignment = .fill
        actionsView.distribution = .fillEqually
        
        actions.forEach {
            $0.font = self.appearance.popMenuFont
            $0.tintColor = $0.color ?? self.appearance.popMenuColor.actionColor.color
            $0.cornerRadius = self.appearance.popMenuCornerRadius / 2
            $0.renderActionView()
            
            let tapper = UITapGestureRecognizer(target: self, action: #selector(menuDidTap(_:)))
            tapper.delaysTouchesEnded = false
            
            $0.view.addGestureRecognizer(tapper)
            
            actionsView.addArrangedSubview($0.view)
        }
        
        contentView.addSubview(actionsView)
        
        NSLayoutConstraint.activate([
            actionsView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            actionsView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            actionsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            actionsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
    
}

// MARK: - Gestures Control

extension PopMenuViewController {

    /// Once the background view is tapped (for dismissal).
    @objc fileprivate func backgroundViewDidTap(_ gesture: UITapGestureRecognizer) {
        guard gesture.isEqual(tapGestureForDismissal), !touchedInsideContent(location: gesture.location(in: view)) else { return }
        
        dismiss(animated: true, completion: nil)
    }
    
    /// When the menu action gets tapped.
    @objc fileprivate func menuDidTap(_ gesture: UITapGestureRecognizer) {
        guard let attachedView = gesture.view, let index = actions.index(where: { $0.view.isEqual(attachedView) }) else { return }

        actionDidSelect(at: index)
    }
    
    /// When the pan gesture triggered in actions view.
    @objc fileprivate func menuDidPan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began, .changed:
            if let index = associatedActionIndex(gesture) {
                let action = actions[index]
                // Must not be already highlighted
                guard !action.highlighted else { return }
                Haptic.selection.generate()
                // Highlight current action view.
                action.highlighted = true
                // Unhighlight other actions.
                actions.filter { return !$0.isEqual(action) }.forEach { $0.highlighted = false }
            }
        case .ended:
            // Unhighlight all actions.
            actions.filter { return $0.highlighted }.forEach { $0.highlighted = false }
            // Trigger action selection.
            if let index = associatedActionIndex(gesture) {
                actionDidSelect(at: index, animated: false)
            }
        default:
            return
        }
    }
    
    /// Check if touch is inside content view.
    fileprivate func touchedInsideContent(location: CGPoint) -> Bool {
        return containerView.frame.contains(location)
    }
    
    ///  Get the gesture associated action index.
    ///
    /// - Parameter gesture: Gesture recognizer
    /// - Returns: The index
    fileprivate func associatedActionIndex(_ gesture: UIGestureRecognizer) -> Int? {
        guard touchedInsideContent(location: gesture.location(in: view)) else { return nil }
        
        // Check which action is associated.
        let touchLocation = gesture.location(in: actionsView)
        // Get associated index for touch location.
        if let touchedView = actionsView.arrangedSubviews.filter({ return $0.frame.contains(touchLocation) }).first,
            let index = actionsView.arrangedSubviews.index(of: touchedView){
            return index
        }
        
        return nil
    }
    
    /// Trigger action selection.
    ///
    /// - Parameter index: The index for action
    fileprivate func actionDidSelect(at index: Int, animated: Bool = true) {
        let action = actions[index]
        action.actionSelected?(animated: animated)
        
        Haptic.impact(.medium).generate()
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
