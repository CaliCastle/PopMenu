//
//  PopMenuAction.swift
//  PopMenu
//
//  Created by Cali Castle  on 4/13/18.
//  Copyright © 2018 PopMenu. All rights reserved.
//

import UIKit

@objc public protocol PopMenuAction {
    
    /// Title of the action.
    var title: String? { get }
    /// Image of the action.
    var image: UIImage? { get }
    /// Container view of the action.
    var view: UIView { get }
    
    static var textLeftPadding: CGFloat { get }
    static var iconLeftPadding: CGFloat { get }
    static var iconWidthHeight: CGFloat { get }
    
    var textColor: UIColor { get set }
    
    var font: UIFont { get set }
    
    /// Render the view for action.
    func renderActionView()
    
}

public class PopMenuDefaultAction: NSObject, PopMenuAction {
    
    public let title: String?
    public let image: UIImage?
    public let view: UIView
    
    /// Text color of the label.
    public var textColor: UIColor {
        get {
            return titleLabel.textColor
        }
        set {
            titleLabel.textColor = newValue
            iconImageView.tintColor = newValue
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.text = title
        
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        
        return imageView
    }()
    
    public static let textLeftPadding: CGFloat = 25
    public static let iconLeftPadding: CGFloat = 18
    public static let iconWidthHeight: CGFloat = 27
    
    public init(title: String? = nil, image: UIImage? = nil) {
        self.title = title
        self.image = image
        
        view = UIView()
    }
    
    fileprivate func configureView() {
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

    public func renderActionView() {
        configureView()
    }
    
}
