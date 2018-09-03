//
//  RootViewController.swift
//  Example
//
//  Created by Cali Castle on 4/12/18.
//  Copyright © 2018 Cali Castle. All rights reserved.
//

import UIKit
import PopMenu

class RootViewController: UITableViewController {

    // Table header titles.
    fileprivate let headers: [String] = [
        "Actions",
        "Background Styles",
        "Customize Appearance",
        "Positions"
    ]
    
    // PopMenu examples helper instance.
    fileprivate let examples = PopMenuExamples()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    /// Top right bar button tapped.
    
    @IBAction func presentMenu(_ sender: UIBarButtonItem) {
        showMenuManually(for: sender)
    }
    
    /// This shows how to use PopMenu the old fashion way
    /// Manually init the controller with actions array
    /// Customize whatever you want and present here
    fileprivate func showMenuManually(for barButtonItem: UIBarButtonItem) {
        // Create menu controller with actions
        let controller = PopMenuViewController(sourceView: barButtonItem, actions: [
            PopMenuDefaultAction(title: "Click me to", image: #imageLiteral(resourceName: "Plus"), color: .yellow),
            PopMenuDefaultAction(title: "Pop another menu", image: #imageLiteral(resourceName: "Heart"), color: #colorLiteral(red: 0.9816910625, green: 0.5655395389, blue: 0.4352460504, alpha: 1)),
            PopMenuDefaultAction(title: "Try it out!", image: nil, color: .white)
        ])
        
        // Customize appearance
        controller.appearance.popMenuFont = UIFont(name: "AvenirNext-DemiBold", size: 16)!
        controller.appearance.popMenuBackgroundStyle = .blurred(.dark)
        // Configure options
        controller.shouldDismissOnSelection = false
        controller.delegate = self
        
        controller.didDismiss = { selected in
            print("Menu dismissed: \(selected ? "selected item" : "no selection")")
        }
        
        // Present menu controller
        present(controller, animated: true, completion: nil)
    }
    
    // MARK: - Table View Row Configuration
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath != IndexPath(row: 0, section: 3) else { return 170 }
        return 68
    }
    
    /// Row selection.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Show designated popmenu
        presentPopMenu(for: indexPath)
    }
    
    // MARK: - Table Header
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = headers[section].uppercased()
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)!
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    /// Height for header views.
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    /// Height for footer views.
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == (headers.count - 1) ? 170 : 30
    }
    
}

extension RootViewController: PopMenuViewControllerDelegate {
    
    func popMenuDidSelectItem(_ popMenuViewController: PopMenuViewController, at index: Int) {
        // Use manager for pop menu
        let manager = PopMenuManager.default
        // Configure actions
        manager.actions = [
            PopMenuDefaultAction(title: "Save to List", image: #imageLiteral(resourceName: "Plus")),
            PopMenuDefaultAction(title: "Favorite", image: #imageLiteral(resourceName: "Heart")),
            PopMenuDefaultAction(title: "Add to Cart", image: #imageLiteral(resourceName: "Cart_Add")),
            PopMenuDefaultAction(title: "Download", image: #imageLiteral(resourceName: "Download"))
        ]
        // Present another PopMenu on an active PopMenu
        manager.present(sourceView: popMenuViewController.actions[index].view,on: popMenuViewController)
    }
    
}

extension RootViewController {
    
    /// Present PopMenu for the specific index path.
    fileprivate func presentPopMenu(for indexPath: IndexPath) {
        let popMenu: PopMenuViewController?
        
        // Get designated PopMenu
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            popMenu = examples.popMenuTextOnly()
        case (0, 1):
            popMenu = examples.popMenuTextAndImage()
        case (0, 2):
            popMenu = examples.popMenuTextAndImage()
            popMenu?.shouldDismissOnSelection = false
        case (0, 3):
            popMenu = examples.popMenuTextAndImage()
            popMenu?.shouldDismissOnSelection = false
            popMenu?.delegate = self
        case (1, 0):
            popMenu = examples.popMenuCustomBackground(.blurred(.dark))
        case (1, 1):
            popMenu = examples.popMenuCustomBackground(.blurred(.light))
        case (1, 2):
            popMenu = examples.popMenuCustomBackground(.dimmed(color: #colorLiteral(red: 0.6151522994, green: 0.7777824998, blue: 0.6126755476, alpha: 1), opacity: 0.4))
        case (1, 3):
            popMenu = examples.popMenuCustomBackground(.dimmed(color: .white, opacity: 0.7))
        case (1, 4):
            popMenu = examples.popMenuCustomBackground(.none())
        case (2, 0):
            popMenu = examples.popMenuCustomActionTintColor(.tint(.lightGray))
        case (2, 1):
            popMenu = examples.popMenuCustomEachActionTintColor()
        case (2, 2):
            popMenu = examples.popMenuCustomFont(UIFont(name: "AvenirNext-DemiBold", size: 15)!)
        case (2, 3):
            popMenu = examples.popMenuCustomFont(UIFont(name: "MarkerFelt-Thin", size: 13)!)
        case (2, 4):
            popMenu = examples.popMenuCustomCornerRadius(0)
        case (2, 5):
            popMenu = examples.popMenuCustomCornerRadius(10)
        case (2, 6):
            popMenu = examples.popMenuCustomActionBackgroundColor(.solid(fill: #colorLiteral(red: 0.431372549, green: 0.6470588235, blue: 0.4509803922, alpha: 1)))
        case (2, 7):
            popMenu = examples.popMenuCustomActionBackgroundColor(.gradient(fill: #colorLiteral(red: 0.4431372549, green: 0.09019607843, blue: 0.9176470588, alpha: 1), #colorLiteral(red: 0.9176470588, green: 0.3764705882, blue: 0.3764705882, alpha: 1)))
        case (2, 8):
            popMenu = examples.popMenuCustomActionHeight(80)
        case (2, 9):
            popMenu = examples.popMenuCustomActionHeight(35)
        case (2, 10):
            popMenu = examples.popMenuCustomStatusBarStyle(.default)
        case (2, 11):
            popMenu = examples.popMenuSeparatorLine(.fill())
        case (2, 12):
            popMenu = examples.popMenuCustomRenderingMode()
        case (3, 0):
            let cell = tableView.cellForRow(at: indexPath)!
            popMenu = examples.popMenuStandard(cell)
        default:
            popMenu = nil
        }
        
        // Present PopMenu if not nil
        if let popMenuViewController = popMenu {
            present(popMenuViewController, animated: true, completion: nil)
        }
    }
    
}
