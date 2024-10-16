//
//  SwitchComponent.swift
//  ComponentKit
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import SnapKit
import ThemeKit

public class SwitchComponent: UIView {
    // MARK: Properties

    public let switchView = UISwitch()

    public var onSwitch: ((Bool) -> Void)?

    // MARK: Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(switchView)
        switchView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        switchView.setContentCompressionResistancePriority(.required, for: .horizontal)
        switchView.setContentHuggingPriority(.required, for: .horizontal)
        switchView.tintColor = .zx005.alpha(0.5)
        switchView.onTintColor = .cg005
        switchView.addTarget(self, action: #selector(handleToggle), for: .valueChanged)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    @objc
    private func handleToggle() {
        onSwitch?(switchView.isOn)
    }
}
