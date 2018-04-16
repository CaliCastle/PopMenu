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

    let headers: [String] = [
        "Actions",
        "Background Styles",
        "Appearance"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func presentMenu(_ sender: UIBarButtonItem) {
        showMenuManually(for: sender)
    }
    
    fileprivate func showMenuManually(for barButtonItem: UIBarButtonItem) {
        // Create menu controller with actions
        let controller = PopMenuViewController(actions: [
            PopMenuDefaultAction(title: "Add to List", image: #imageLiteral(resourceName: "Plus"), color: .yellow),
            PopMenuDefaultAction(title: "Favorite", image: #imageLiteral(resourceName: "Heart"), color: #colorLiteral(red: 0.9816910625, green: 0.5655395389, blue: 0.4352460504, alpha: 1))
            ])
        
        // Customize appearance
        controller.appearance.popMenuFont = UIFont(name: "AvenirNext-DemiBold", size: 16)!
        controller.appearance.popMenuBackgroundStyle = .blurred(.dark)
        // Configure options
        controller.shouldDismissOnSelection = false
        // Set delegate for selection callback
        controller.delegate = self
        // Since `UIBarButtonItem` is not a subclass of `UIView`, we need to
        // know the view's frame to make the relative position work
        controller.setBarButtonItemForSourceView(barButtonItem)
        
        // Present menu controller
        present(controller, animated: true, completion: nil)
    }
    
    // MARK: - Row Configuration
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
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
        manager.present(sourceView: popMenuViewController.containerView, on: popMenuViewController)
    }
    
}
