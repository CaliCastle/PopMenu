//
//  UIView+Shadows.swift
//  PopMenu
//
//  Created by Cali Castle on 4/14/18.
//  Copyright © 2018 PopMenu. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Quick configuration to give the view shadows.
    public func addShadow(offset: CGSize = .zero, opacity: Float = 0.65, radius: CGFloat = 20, color: UIColor = .black) {
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.masksToBounds = false
    }
    
}
