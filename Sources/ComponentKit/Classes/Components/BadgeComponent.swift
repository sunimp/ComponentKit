//
//  BadgeComponent.swift
//  ComponentKit
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import SnapKit

public class BadgeComponent: UIView {
    // MARK: Properties

    public let badgeView = BadgeView()

    // MARK: Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(badgeView)
        badgeView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
