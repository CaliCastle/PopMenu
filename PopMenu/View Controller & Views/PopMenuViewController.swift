//
//  PopMenuViewController.swift
//  PopMenu
//
//  Created by Cali Castle on 4/12/18.
//  Copyright © 2018 Cali Castle. All rights reserved.
//

import UIKit

/// Delegate for handling PopMenu selection.
@objc public protocol PopMenuViewControllerDelegate: class {
    /// Called when an action is selected.
    @objc optional func popMenuDidSelectItem(_ popMenuViewController: PopMenuViewController, at index: Int)
}

final public class PopMenuViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Delegate instance for handling callbacks.
    public weak var delegate: PopMenuViewControllerDelegate?
    
    /// Appearance configuration.
    public var appearance = PopMenuAppearance()
    
    /// Background overlay that covers the whole screen.
    public let backgroundView = UIView()
    
    /// The blur overlay view for translucent illusion.
    private lazy var blurOverlayView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = appearance.popMenuCornerRadius
        blurView.layer.masksToBounds = true
        blurView.isUserInteractionEnabled = false
        
        return blurView
    }()
    
    /// Main root view that has shadows.
    public let containerView = UIView()
    
    /// Main content view.
    public let contentView = PopMenuGradientView()
    
    /// The view contains all the actions.
    public let actionsView = UIStackView()
    
    /// The source View to be displayed from.
    private(set) weak var sourceView: AnyObject?
    
    /// The absolute source frame relative to screen.
    private(set) var absoluteSourceFrame: CGRect?
    
    /// The calculated content frame.
    public lazy var contentFrame: CGRect = {
        return calculateContentFittingFrame()
    }()
    
    // MARK: - Configurations
    
    /// Determines whether to dismiss menu after an action is selected.
    public var shouldDismissOnSelection: Bool = true
    
    /// Determines whether the pan gesture is enabled on the actions.
    public var shouldEnablePanGesture: Bool = true
    
    /// Determines whether enable haptics for iPhone 7 and up.
    public var shouldEnableHaptics: Bool = true
    
    /// Handler for when the menu is dismissed.
    public var didDismiss: ((Bool) -> Void)?
    
    // MARK: - Constraints
    
    private(set) var contentLeftConstraint: NSLayoutConstraint!
    private(set) var contentTopConstraint: NSLayoutConstraint!
    private(set) var contentWidthConstraint: NSLayoutConstraint!
    private(set) var contentHeightConstraint: NSLayoutConstraint!
    
    /// The UIView instance of source view.
    fileprivate lazy var sourceViewAsUIView: UIView? = {
        guard let sourceView = sourceView else { return nil }
        
        // Check if UIBarButtonItem
        if let sourceBarButtonItem = sourceView as? UIBarButtonItem {
            if let buttonView = sourceBarButtonItem.value(forKey: "view") as? UIView {
                return buttonView
            }
        }
        
        if let sourceView = sourceView as? UIView {
            return sourceView
        }
        
        return nil
    }()
    
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
    
    /// Actions of menu.
    public private(set) var actions: [PopMenuAction] = []
    
    /// Max content width allowed for the content to stretch to.
    fileprivate let maxContentWidth: CGFloat = UIScreen.main.bounds.size.width * 0.9
    
    // MARK: - View Life Cycle
    
    public convenience init(sourceView: AnyObject? = nil, actions: [PopMenuAction], appearance: PopMenuAppearance? = nil) {
        self.init(nibName: nil, bundle: nil)
        
        self.sourceView = sourceView
        self.actions = actions

        // Assign appearance or use the default one.
        if let appearance = appearance {
            self.appearance = appearance
        }

        setAbsoluteSourceFrame()
        
        transitioningDelegate = self
        modalPresentationStyle = .overFullScreen
        modalPresentationCapturesStatusBarAppearance = true
    }
    
    /// Load view entry point.
    public override func loadView() {
        super.loadView()

        view.backgroundColor = .clear
        
        configureBackgroundView()
        configureContentView()
        configureActionsView()
    }
    
    /// Set absolute source frame relative to screen frame.
    fileprivate func setAbsoluteSourceFrame() {
        if let sourceView = sourceViewAsUIView {
            absoluteSourceFrame = sourceView.convert(sourceView.bounds, to: nil)
        }
    }
    
    /// Add a new action to the menu.
    ///
    /// - Parameter action: Action to be added
    public func addAction(_ action: PopMenuAction) {
        actions.append(action)
    }
    
    // MARK: - Status Bar Appearance
    
    public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    /// Set status bar style.
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        // If style defined, return
        if let statusBarStyle = appearance.popMenuStatusBarStyle {
            return statusBarStyle
        }
        
        // Contrast of blur style
        let backgroundStyle = appearance.popMenuBackgroundStyle
        if let blurStyle = backgroundStyle.blurStyle {
            switch blurStyle {
            case .dark:
                return .lightContent
            default:
                return .default
            }
        }
        
        // Contrast of dimmed color
        if let dimColor = backgroundStyle.dimColor {
            return dimColor.blackOrWhiteContrastingColor() == .white ? .lightContent : .default
        }
        
        return .lightContent
    }
    
}

// MARK: - View Configurations

extension PopMenuViewController {
    
    /// Setup the background view at the bottom.
    fileprivate func configureBackgroundView() {
        backgroundView.frame = view.frame
        backgroundView.backgroundColor = .clear
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addGestureRecognizer(tapGestureForDismissal)
        backgroundView.isUserInteractionEnabled = true
        
        let backgroundStyle = appearance.popMenuBackgroundStyle
        
        // Blurred background
        if let isBlurred = backgroundStyle.isBlurred,
            isBlurred,
            let blurStyle = backgroundStyle.blurStyle {
            
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
            blurView.frame = backgroundView.frame
            
            backgroundView.addSubview(blurView)
        }
        
        // Dimmed background
        if let isDimmed = backgroundStyle.isDimmed,
            isDimmed,
            let color = backgroundStyle.dimColor,
            let opacity = backgroundStyle.dimOpacity {
            
            backgroundView.backgroundColor = color.withAlphaComponent(opacity)
        }
        
        view.insertSubview(backgroundView, at: 0)
    }
    
    /// Setup the content view.
    fileprivate func configureContentView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addShadow(offset: .init(width: 0, height: 1), opacity: 0.5, radius: 20)
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
                // Configure solid fill background.
                contentView.backgroundColor = colors.first?.withAlphaComponent(0.9)
                contentView.startColor = .clear
                contentView.endColor = .clear
            } else {
                // Configure gradient color.
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
    
    /// Activate necessary constraints.
    fileprivate func setupContentConstraints() {
        contentLeftConstraint = containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: contentFrame.origin.x)
        contentTopConstraint = containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: contentFrame.origin.y)
        contentWidthConstraint = containerView.widthAnchor.constraint(equalToConstant: contentFrame.size.width)
        contentHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: contentFrame.size.height)
        
        // Activate container view constraints
        NSLayoutConstraint.activate([
            contentLeftConstraint,
            contentTopConstraint,
            contentWidthConstraint,
            contentHeightConstraint
        ])
        // Activate content view constraints
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            contentView.topAnchor.constraint(equalTo: containerView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        // Activate blur overlay constraints
        NSLayoutConstraint.activate([
            blurOverlayView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            blurOverlayView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            blurOverlayView.topAnchor.constraint(equalTo: containerView.topAnchor),
            blurOverlayView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    /// Determine the fitting frame for content.
    ///
    /// - Returns: The fitting frame
    fileprivate func calculateContentFittingFrame() -> CGRect {
        let size = CGSize(width: calculateContentWidth(), height: CGFloat(actions.count) * appearance.popMenuActionHeight)
        let origin = calculateContentOrigin(with: size)
        
        return CGRect(origin: origin, size: size)
    }
    
    /// Determine where the menu should display.
    ///
    /// - Returns: The source origin point
    fileprivate func calculateContentOrigin(with size: CGSize) -> CGPoint {
        guard let sourceFrame = absoluteSourceFrame else { return CGPoint(x: view.center.x - size.width / 2, y: view.center.y - size.height / 2) }
        
        // Get desired content origin point
        let offsetX = (size.width - sourceFrame.size.width ) / 2
        var desiredOrigin = CGPoint(x: sourceFrame.origin.x - offsetX, y: sourceFrame.origin.y)
        
        // Move content in place
        translateOverflowX(desiredOrigin: &desiredOrigin, contentSize: size)
        translateOverflowY(desiredOrigin: &desiredOrigin, contentSize: size)
        
        return desiredOrigin
    }
    
    /// Move content into view if it's overflowed in X axis.
    ///
    /// - Parameters:
    ///   - desiredOrigin: The desired origin point
    ///   - contentSize: Content size
    fileprivate func translateOverflowX(desiredOrigin: inout CGPoint, contentSize: CGSize) {
        let edgePadding: CGFloat = 8
        // Check content in left or right side
        let leftSide = (desiredOrigin.x - view.center.x) < 0
        
        // Check view overflow
        let origin = CGPoint(x: leftSide ? desiredOrigin.x : desiredOrigin.x + contentSize.width, y: desiredOrigin.y)
        
        // Move accordingly
        if !view.frame.contains(origin) {
            let overflowX: CGFloat = (leftSide ? 1 : -1) * ((leftSide ? view.frame.origin.x : view.frame.origin.x + view.frame.size.width) - origin.x) + edgePadding
            
            desiredOrigin = CGPoint(x: desiredOrigin.x - (leftSide ? -1 : 1) * overflowX, y: origin.y)
        }
    }
    
    /// Move content into view if it's overflowed in Y axis.
    ///
    /// - Parameters:
    ///   - desiredOrigin: The desired origin point
    ///   - contentSize: Content size
    fileprivate func translateOverflowY(desiredOrigin: inout CGPoint, contentSize: CGSize) {
        let edgePadding: CGFloat

        let origin = CGPoint(x: desiredOrigin.x, y: desiredOrigin.y + contentSize.height)

        if #available(iOS 11.0, *) {
            edgePadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 8
        } else {
            edgePadding = 8
        }
        
        // Check content inside of view or not
        if !view.frame.contains(origin) {
            let overFlowY: CGFloat = origin.y - view.frame.size.height + edgePadding
            
            desiredOrigin = CGPoint(x: desiredOrigin.x, y: desiredOrigin.y - overFlowY)
        }
    }
    
    /// Determine the content width by the longest title possible.
    ///
    /// - Returns: The fitting width for content
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
    
    /// Setup actions view.
    fileprivate func configureActionsView() {
        actionsView.addGestureRecognizer(panGestureForMenu)
        
        actionsView.translatesAutoresizingMaskIntoConstraints = false
        actionsView.axis = .vertical
        actionsView.alignment = .fill
        actionsView.distribution = .fillEqually

        // Configure each action
        actions.forEach { action in
            action.font = appearance.popMenuFont
            action.tintColor = action.color ?? appearance.popMenuColor.actionColor.color
            action.cornerRadius = appearance.popMenuCornerRadius / 2
            action.renderActionView()
            
            // Give separator to each action but the last
            if !action.isEqual(actions.last) {
                addSeparator(to: action.view)
            }
            
            let tapper = UITapGestureRecognizer(target: self, action: #selector(menuDidTap(_:)))
            tapper.delaysTouchesEnded = false
            
            action.view.addGestureRecognizer(tapper)
            
            actionsView.addArrangedSubview(action.view)
        }
        
        contentView.addSubview(actionsView)
        
        NSLayoutConstraint.activate([
            actionsView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            actionsView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            actionsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            actionsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
    
    /// Add separator view for the given action view.
    ///
    /// - Parameters:
    ///   - separator: Separator style
    ///   - actionView: Action's view
    fileprivate func addSeparator(to actionView: UIView) {
        // Only setup separator if the style is neither 0 height or clear color
        guard appearance.popMenuItemSeparator != .none() else { return }
        
        let separator = appearance.popMenuItemSeparator
        
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = separator.color
        
        actionView.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            separatorView.leftAnchor.constraint(equalTo: actionView.leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: actionView.rightAnchor),
            separatorView.bottomAnchor.constraint(equalTo: actionView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: separator.height)
        ])
    }
    
}

// MARK: - Gestures Control

extension PopMenuViewController {

    /// Once the background view is tapped (for dismissal).
    @objc fileprivate func backgroundViewDidTap(_ gesture: UITapGestureRecognizer) {
        guard gesture.isEqual(tapGestureForDismissal), !touchedInsideContent(location: gesture.location(in: view)) else { return }
        
        dismiss(animated: true) {
            // No selection made.
            self.didDismiss?(false)
        }
    }
    
    /// When the menu action gets tapped.
    @objc fileprivate func menuDidTap(_ gesture: UITapGestureRecognizer) {
        guard let attachedView = gesture.view, let index = actions.index(where: { $0.view.isEqual(attachedView) }) else { return }

        actionDidSelect(at: index)
    }
    
    /// When the pan gesture triggered in actions view.
    @objc fileprivate func menuDidPan(_ gesture: UIPanGestureRecognizer) {
        guard shouldEnablePanGesture else { return }
        
        switch gesture.state {
        case .began, .changed:
            if let index = associatedActionIndex(gesture) {
                let action = actions[index]
                // Must not be already highlighted
                guard !action.highlighted else { return }
                
                if shouldEnableHaptics {
                    Haptic.selection.generate()
                }
                
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
    
    /// Triggers when an action is selected.
    ///
    /// - Parameter index: The index for action
    fileprivate func actionDidSelect(at index: Int, animated: Bool = true) {
        let action = actions[index]
        action.actionSelected?(animated: animated)
        
        if shouldEnableHaptics {
            // Generate haptics
            Haptic.impact(.medium).generate()
        }
        
        // Notify delegate
        delegate?.popMenuDidSelectItem?(self, at: index)
        
        // Should dismiss or not
        if shouldDismissOnSelection {
            dismiss(animated: true) {
                // Selection made.
                self.didDismiss?(true)
            }
        }
    }
    
}

// MARK: - Transitioning Delegate

extension PopMenuViewController: UIViewControllerTransitioningDelegate {
    
    /// Custom presentation animation.
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopMenuPresentAnimationController(sourceFrame: absoluteSourceFrame)
    }
    
    /// Custom dismissal animation.
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopMenuDismissAnimationController(sourceFrame: absoluteSourceFrame)
    }

}
