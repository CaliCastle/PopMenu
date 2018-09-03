//
//  PopMenuExamples.swift
//  Example
//
//  Created by Cali Castle  on 4/16/18.
//  Copyright © 2018 Cali Castle. All rights reserved.
//

import UIKit
import PopMenu

/// PopMenu Examples Helper Class
final class PopMenuExamples {
    
    /// PopMenu with only texts.
    func popMenuTextOnly() -> PopMenuViewController {
        let actions = [
            PopMenuDefaultAction(title: "Some Text"),
            PopMenuDefaultAction(title: "Short"),
            PopMenuDefaultAction(title: "A Longer Text")
        ]
        
        let popMenu = PopMenuViewController(actions: actions)
        
        return popMenu
    }
    
    /// A standard PopMenu with texts and images.
    func popMenuTextAndImage() -> PopMenuViewController {
        let actions = [
            PopMenuDefaultAction(title: "Save to List", image: #imageLiteral(resourceName: "Plus")),
            PopMenuDefaultAction(title: "Favorite", image: #imageLiteral(resourceName: "Heart")),
            PopMenuDefaultAction(title: "Add to Cart", image: #imageLiteral(resourceName: "Cart_Add")),
            PopMenuDefaultAction(title: "Download", image: #imageLiteral(resourceName: "Download"))
        ]
        
        let popMenu = PopMenuViewController(actions: actions)
        
        return popMenu
    }
    
    /// PopMenu with custom background.
    func popMenuCustomBackground(_ backgroundStyle: PopMenuBackgroundStyle) -> PopMenuViewController {
        let popMenu = popMenuTextAndImage()
        
        popMenu.appearance.popMenuBackgroundStyle = backgroundStyle
        
        return popMenu
    }
    
    /// PopMenu with custom actions tint color.
    func popMenuCustomActionTintColor(_ actionTintColor: PopMenuActionColor) -> PopMenuViewController {
        let popMenu = popMenuTextAndImage()
        
        popMenu.appearance.popMenuColor.actionColor = actionTintColor
        
        return popMenu
    }
    
    /// PopMenu with each custom action tint color.
    func popMenuCustomEachActionTintColor() -> PopMenuViewController {
        let actions = [
            PopMenuDefaultAction(title: "Save to List", image: #imageLiteral(resourceName: "Plus"), color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
            PopMenuDefaultAction(title: "Favorite", image: #imageLiteral(resourceName: "Heart"), color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
            PopMenuDefaultAction(title: "Add to Cart", image: #imageLiteral(resourceName: "Cart_Add"), color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)),
            PopMenuDefaultAction(title: "Download", image: #imageLiteral(resourceName: "Download"), color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        ]
        
        let popMenu = PopMenuViewController(actions: actions)
        
        return popMenu
    }
    
    /// PopMenu with custom action font.
    func popMenuCustomFont(_ font: UIFont) -> PopMenuViewController {
        let popMenu = popMenuTextAndImage()
        
        popMenu.appearance.popMenuFont = font
        
        return popMenu
    }
    
    /// PopMenu with custom corner radius.
    func popMenuCustomCornerRadius(_ cornerRadius: CGFloat) -> PopMenuViewController {
        let popMenu = popMenuTextAndImage()
        
        popMenu.appearance.popMenuCornerRadius = cornerRadius
        
        return popMenu
    }
    
    /// PopMenu with custom action background color.
    func popMenuCustomActionBackgroundColor(_ actionBackgroundColor: PopMenuActionBackgroundColor) -> PopMenuViewController {
        let popMenu = popMenuTextAndImage()
        
        popMenu.appearance.popMenuColor.backgroundColor = actionBackgroundColor
        
        return popMenu
    }
    
    /// PopMenu with custom action height.
    func popMenuCustomActionHeight(_ height: CGFloat) -> PopMenuViewController {
        let popMenu = popMenuTextAndImage()
        
        popMenu.appearance.popMenuActionHeight = height
        
        return popMenu
    }
    
    /// PopMenu with custom status bar style.
    func popMenuCustomStatusBarStyle(_ statusBarStyle: UIStatusBarStyle) -> PopMenuViewController {
        let popMenu = popMenuTextAndImage()
        
        popMenu.appearance.popMenuStatusBarStyle = statusBarStyle
        
        return popMenu
    }
    
    /// PopMenu with separator line.
    func popMenuSeparatorLine(_ separatorStyle: PopMenuActionSeparator) -> PopMenuViewController {
        let popMenu = popMenuTextAndImage()

        popMenu.appearance.popMenuItemSeparator = separatorStyle

        return popMenu
    }

    /// PopMenu with source view.
    func popMenuStandard(_ sourceView: UIView) -> PopMenuViewController {
        let actions = [
            PopMenuDefaultAction(title: "Save to List", image: #imageLiteral(resourceName: "Plus"), color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
            PopMenuDefaultAction(title: "Favorite", image: #imageLiteral(resourceName: "Heart"), color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
            PopMenuDefaultAction(title: "Add to Cart", image: #imageLiteral(resourceName: "Cart_Add"), color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
        ]
        
        let popMenu = PopMenuViewController(sourceView: sourceView, actions: actions)
        
        return popMenu
    }
    
    /// PopMenu with custom image rendering mode.
    func popMenuCustomRenderingMode() -> PopMenuViewController {
        let action1 = PopMenuDefaultAction(title: "Open in Chrome", image: #imageLiteral(resourceName: "chrome"), color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
        let action2 = PopMenuDefaultAction(title: "Open in Safari", image: #imageLiteral(resourceName: "safari"), color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        let action3 = PopMenuDefaultAction(title: "Open in Firefox", image: #imageLiteral(resourceName: "firefox"), color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
        
        let actions = [
            action1,
            action2,
            action3
        ]
        
        actions.forEach({
            $0.imageRenderingMode = .alwaysOriginal
            
        })
        
        let popMenu = PopMenuViewController(actions: actions)
        
        return popMenu
    }
    
    /// PopMenu with custom image sizing.
    func popMenuCustomSize() -> PopMenuViewController {
        let action1 = PopMenuDefaultAction(title: "Open in Chrome", image: #imageLiteral(resourceName: "chrome"), color: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
        let action2 = PopMenuDefaultAction(title: "Open in Safari", image: #imageLiteral(resourceName: "safari"), color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        let action3 = PopMenuDefaultAction(title: "Open in Firefox", image: #imageLiteral(resourceName: "firefox"), color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
        
        let actions = [
            action1,
            action2,
            action3
        ]
        
        actions.forEach({
            $0.imageRenderingMode = .alwaysOriginal
            $0.iconWidthHeight = 42
        })
        
        let popMenu = PopMenuViewController(actions: actions)
        
        return popMenu
    }
    
}
