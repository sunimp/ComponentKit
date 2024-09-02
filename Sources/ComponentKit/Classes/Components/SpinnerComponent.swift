//
//  SpinnerComponent.swift
//
//  Created by Sun on 2022/10/6.
//

import UIKit

import HUD
import SnapKit
import ThemeKit

public class SpinnerComponent: UIView {
    // MARK: Properties

    private let spinner: HUDActivityView

    // MARK: Lifecycle

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
}
