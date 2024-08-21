//
//  SwitchComponent.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/20.
//

import UIKit

import ThemeKit
import SnapKit

public class SwitchComponent: UIView {
    
    public let switchView = UISwitch()

    public var onSwitch: ((Bool) -> Void)?

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
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc 
    private func handleToggle() {
        onSwitch?(switchView.isOn)
    }

}
