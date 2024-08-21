//
//  DeterminiteSpinnerComponent.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/20.
//

import UIKit

import SnapKit
import ThemeKit
import HUD

public class DeterminiteSpinnerComponent: UIView {
    
    private let spinner: HUDProgressView

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
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(progress: Double) {
        spinner.set(progress: Float(progress))
        spinner.startAnimating()
    }

}
