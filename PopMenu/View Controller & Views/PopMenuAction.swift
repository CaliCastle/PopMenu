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
    
    public init(title: String? = nil, image: UIImage? = nil) {
        self.title = title
        self.image = image
        
        view = UIView()
    }
    
    fileprivate func configureView() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    public func renderActionView() {
        configureView()
    }
    
}
