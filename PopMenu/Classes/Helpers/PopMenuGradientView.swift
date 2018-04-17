//
//  PopMenuGradientView.swift
//  PopMenu
//
//  Created by Cali Castle on 4/13/18.
//  Copyright © 2018 PopMenu. All rights reserved.
//

import UIKit

public final class PopMenuGradientView: UIView {
    
    // MARK: - Properties
    
    /// Gradient starting color.
    var startColor:   UIColor = .black { didSet { updateColors() }}
    
    /// Gradient ending color.
    var endColor:     UIColor = .white { didSet { updateColors() }}
    
    /// Gradient starting location.
    var startLocation: Double =   0.05 { didSet { updateLocations() }}
    
    /// Gradient ending location.
    var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    
    /// Is horizontal gradient or not.
    var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    
    /// Is diagonal gradient or not.
    var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    /// The layer class type.
    override public class var layerClass: AnyClass { return CAGradientLayer.self }
    
    /// View's gradient layer.
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    /// Update gradient points.
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    
    /// Update gradient locations.
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    
    /// Update gradient colors.
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }
    
    /// Setup gradient properties.
    func setup() {
        updatePoints()
        updateLocations()
        updateColors()
    }
    
    /// Layout subviews override.
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
}
