//
//  SecondaryButtonComponent.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/20.
//

import UIKit

import ThemeKit
import SnapKit

public class SecondaryButtonComponent: UIView {
    
    public let button = SecondaryButton()
    private let dummyButton = ComponentButton()

    public var onTap: (() -> Void)?

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(dummyButton)
        addSubview(button)

        dummyButton.snp.makeConstraints { maker in
            maker.edges.equalTo(button)
        }

        button.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func handleTap() {
        onTap?()
    }

}
