//
//  PrimaryCircleButtonComponent.swift
//  ComponentKit
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import SnapKit
import ThemeKit

public class PrimaryCircleButtonComponent: UIView {
    // MARK: Properties

    public let button = PrimaryCircleButton()
    public var onTap: (() -> Void)?

    private let dummyButton = UIButton()

    // MARK: Lifecycle

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
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    @objc
    private func handleTap() {
        onTap?()
    }
}
