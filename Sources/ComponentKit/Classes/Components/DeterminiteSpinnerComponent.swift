//
//  DeterminiteSpinnerComponent.swift
//
//  Created by Sun on 2022/10/6.
//

import UIKit

import HUD
import SnapKit
import ThemeKit

public class DeterminiteSpinnerComponent: UIView {
    // MARK: Properties

    private let spinner: HUDProgressView

    // MARK: Lifecycle

    public init(size: CGFloat) {
        spinner = HUDProgressView(
            progress: 0,
            strokeLineWidth: 2,
            radius: (size - 2) / 2,
            strokeColor: .zx003,
            donutColor: .zx005.alpha(0.5),
            duration: 2
        )

        super.init(frame: .zero)

        addSubview(spinner)
        spinner.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.size.equalTo(size)
        }
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    public func set(progress: Double) {
        spinner.set(progress: Float(progress))
        spinner.startAnimating()
    }
}
