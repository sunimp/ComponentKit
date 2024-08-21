//
//  SpinnerComponent.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/20.
//

import UIKit

import ThemeKit
import SnapKit
import HUD

public class SpinnerComponent: UIView {
    
    private let spinner: HUDActivityView

    init(style: ActivityIndicatorStyle) {
        spinner = HUDActivityView.create(with: style)

        super.init(frame: .zero)

        addSubview(spinner)
        spinner.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        spinner.startAnimating()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
