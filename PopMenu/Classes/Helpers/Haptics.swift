//
//  Haptics.swift
//  PopMenu
//
//  Created by Cali Castle on 4/14/18.
//  Copyright © 2018 PopMenu. All rights reserved.
//

import UIKit

/// Haptic Generator Helper.
public enum Haptic {
    
    /// Impact style.
    case impact(UIImpactFeedbackStyle)
    
    /// Notification style.
    case notification(UINotificationFeedbackType)
    
    /// Selection style.
    case selection
    
    /// Trigger haptic generator.
    public func generate() {
        guard #available(iOS 10, *) else { return }
        
        switch self {
        case .impact(let style):
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.prepare()
            generator.impactOccurred()
        case .notification(let type):
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
}

