import UIKit

extension UIView {
    
    /// Apply basic gradients.
    func applyGradient(colors: [UIColor]) {
        applyGradient(colors: colors, locations: nil)
    }
    
    /// Apply horizontal gradient layer.
    func applyHorizontalGradient(colors: [UIColor]) {
        applyGradient(colors: colors, locations: nil, horizontal: true)
    }
    
    /// Apply diagonal gradient layer.
    func applyDiagonalGradient(colors: [UIColor]) {
        applyGradient(colors: colors, locations: nil, diagonal: true)
    }
    
    /// Apply full gradient layer.
    func applyGradient(colors: [UIColor], locations: [NSNumber]?, diagonal: Bool = false, horizontal: Bool = false) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        
        if horizontal {
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        } else {
            gradient.startPoint = diagonal ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradient.endPoint = diagonal ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
        
        layer.insertSublayer(gradient, at: 0)
    }

}
