//
//  MainController.swift
//  ComponentKit-Example
//
//  Created by Sun on 2024/8/19.
//

import SwiftUI
import UIKit

import ThemeKit
import SnapKit

class MainController: ThemeTabBarController {

    init(selectedIndex: Int = 0) {
        super.init()

        let buttonsTitle = "Buttons"
        let buttonsController = ButtonsController()
        buttonsController.title = buttonsTitle
        buttonsController.tabBarItem = ThemeTabBarItem(
            title: buttonsTitle,
            image: UIImage(systemName: "button.programmable.square.fill")?.withRenderingMode(.alwaysTemplate),
            tag: 0
        )
        
        let cellsTitle = "Cells"
        let cellsController = CellsController()
        cellsController.title = cellsTitle
        cellsController.tabBarItem = ThemeTabBarItem(
            title: cellsTitle,
            image: UIImage(systemName: "tablecells.badge.ellipsis")?.withRenderingMode(.alwaysTemplate),
            tag: 0
        )
        
        let experimentalTitle = "Experimental"
        let experimentalView = ExperimentalView()
        let experimentalController = UIHostingController(rootView: experimentalView)
        experimentalController.title = experimentalTitle
        experimentalController.tabBarItem = ThemeTabBarItem(
            title: experimentalTitle,
            image: UIImage(named: "TabBar Icon")?.resize(CGSize(width: 18, height: 18)),
            tag: 0
        )
        
        viewControllers = [
            ThemeNavigationController(rootViewController: buttonsController),
            ThemeNavigationController(rootViewController: cellsController),
            ThemeNavigationController(rootViewController: experimentalController)
        ]

        self.selectedIndex = selectedIndex
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
