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
    /// Render the view for action.
    func renderActionView()
    
}

public class PopMenuDefaultAction: NSObject, PopMenuAction {
    
    public let title: String?
    public let image: UIImage?
    public let view: UIView
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.isEnabled = true
        button.isUserInteractionEnabled = false
        
        return button
    }()
    
    public init(title: String? = nil, image: UIImage? = nil) {
        self.title = title
        self.image = image
        
        view = UIView()
    }
    
    fileprivate func configureView() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    public func renderActionView() {
        configureView()
    }
    
}
