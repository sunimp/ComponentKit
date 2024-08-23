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
            image: UIImage(systemName: "button.programmable.square.fill")?.withRenderingMode(.alwaysTemplate).resize(CGSize(width: 28, height: 25)),
            tag: 0
        )
        
        let cellsTitle = "Cells"
        let cellsController = CellsController()
        cellsController.title = cellsTitle
        cellsController.tabBarItem = ThemeTabBarItem(
            title: cellsTitle,
            image: UIImage(systemName: "tablecells.badge.ellipsis")?.withRenderingMode(.alwaysTemplate).resize(CGSize(width: 28, height: 22)),
            tag: 0
        )
        
        let experimentalTitle = "Experimental"
        let experimentalView = ExperimentalView()
        let experimentalController = UIHostingController(rootView: experimentalView)
        experimentalController.title = experimentalTitle
        experimentalController.tabBarItem = ThemeTabBarItem(
            title: experimentalTitle,
            image: UIImage(named: "TabBar Icon")?.resize(CGSize(width: 24, height: 24)),
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
