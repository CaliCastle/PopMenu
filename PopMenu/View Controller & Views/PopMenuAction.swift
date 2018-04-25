//
//  PopMenuAction.swift
//  PopMenu
//
//  Created by Cali Castle  on 4/13/18.
//  Copyright © 2018 PopMenu. All rights reserved.
//

import UIKit

/// Customize your own action and conform to `PopMenuAction` protocol.
@objc public protocol PopMenuAction: NSObjectProtocol {
    
    /// Title of the action.
    var title: String? { get }
    
    /// Image of the action.
    var image: UIImage? { get }
    
    /// Container view of the action.
    var view: UIView { get }
    
    /// The initial color of the action.
    var color: Color? { get }
    
    /// The handler of action.
    var didSelect: PopMenuActionHandler? { get }
    
    /// Left padding when texts-only.
    static var textLeftPadding: CGFloat { get }
    
    /// Icon left padding when icons are present.
    static var iconLeftPadding: CGFloat { get }
    
    /// Icon sizing.
    static var iconWidthHeight: CGFloat { get }
    
    /// The color to set for both label and icon.
    var tintColor: UIColor { get set }
    
    /// The font for label.
    var font: UIFont { get set }
    
    /// The corner radius of action view.
    var cornerRadius: CGFloat { get set }
    
    /// Is the view highlighted by gesture.
    var highlighted: Bool { get set }
    
    /// Render the view for action.
    func renderActionView()

    /// Called when the action gets selected.
    @objc optional func actionSelected(animated: Bool)
 
    /// Type alias for selection handler.
    typealias PopMenuActionHandler = (PopMenuAction) -> Void
    
}

/// The default PopMenu action class.
public class PopMenuDefaultAction: NSObject, PopMenuAction {
    
    /// Title of action.
    public let title: String?
    
    /// Icon of action.
    public let image: UIImage?
    
    /// Renderred view of action.
    public let view: UIView
    
    /// Color of action.
    public let color: Color?
    
    /// Handler of action when selected.
    public let didSelect: PopMenuActionHandler?
    
    // MARK: - Computed Properties
    
    /// Text color of the label.
    public var tintColor: Color {
        get {
            return titleLabel.textColor
        }
        set {
            titleLabel.textColor = newValue
            iconImageView.tintColor = newValue
            backgroundColor = newValue.blackOrWhiteContrastingColor()
        }
    }
    
    /// Font for the label.
    public var font: UIFont {
        get {
            return titleLabel.font
        }
        set {
            titleLabel.font = newValue
        }
    }
    
    /// Rounded corner radius for action view.
    public var cornerRadius: CGFloat {
        get {
            return view.layer.cornerRadius
        }
        set {
            view.layer.cornerRadius = newValue
        }
    }
    
    /// Inidcates if the action is being highlighted.
    public var highlighted: Bool = false {
        didSet {
            guard highlighted != oldValue else { return }
            
            highlightActionView(highlighted)
        }
    }
    
    /// Background color for highlighted state.
    private var backgroundColor: Color = .white

    // MARK: - Subviews
    
    /// Title label view instance.
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.text = title
        
        return label
    }()
    
    /// Icon image view instance.
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        
        return imageView
    }()
    
    // MARK: - Constants
    
    public static let textLeftPadding: CGFloat = 25
    public static let iconLeftPadding: CGFloat = 18
    public static let iconWidthHeight: CGFloat = 27
    
    // MARK: - Initializer
    
    /// Initializer.
    public init(title: String? = nil, image: UIImage? = nil, color: Color? = nil, didSelect: PopMenuActionHandler? = nil) {
        self.title = title
        self.image = image
        self.color = color
        self.didSelect = didSelect
        
        view = UIView()
    }
    
    /// Setup necessary views.
    fileprivate func configureViews() {
        var hasImage = false

        if let _ = image {
            hasImage = true
            view.addSubview(iconImageView)
            
            NSLayoutConstraint.activate([
                iconImageView.widthAnchor.constraint(equalToConstant: PopMenuDefaultAction.iconWidthHeight),
                iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
                iconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PopMenuDefaultAction.iconLeftPadding),
                iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: hasImage ? iconImageView.trailingAnchor : view.leadingAnchor, constant: hasImage ? 8 : PopMenuDefaultAction.textLeftPadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    /// Load and configure the action view.
    public func renderActionView() {
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        
        configureViews()
    }
    
    /// Highlight the view when panned on top,
    /// unhighlight the view when pan gesture left.
    public func highlightActionView(_ highlight: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.26, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 9, options: self.highlighted ? .curveEaseIn : .curveEaseOut, animations: {
                self.view.transform = self.highlighted ? CGAffineTransform.identity.scaledBy(x: 1.09, y: 1.09) : .identity
                self.view.backgroundColor = self.highlighted ? self.backgroundColor.withAlphaComponent(0.25) : .clear
            }, completion: nil)
        }
    }
    
    /// When the action is selected.
    public func actionSelected(animated: Bool) {
        // Trigger handler.
        didSelect?(self)
        
        // Animate selection
        guard animated else { return }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.175, animations: {
                self.view.transform = CGAffineTransform.identity.scaledBy(x: 0.915, y: 0.915)
                self.view.backgroundColor = self.backgroundColor.withAlphaComponent(0.18)
            }, completion: {
                if $0 {
                    UIView.animate(withDuration: 0.175, animations: {
                        self.view.transform = .identity
                        self.view.backgroundColor = .clear
                    })
                }
            })
        }
    }
    
}
