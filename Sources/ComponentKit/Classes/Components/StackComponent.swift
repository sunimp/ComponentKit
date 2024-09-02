//
//  StackComponent.swift
//
//  Created by Sun on 2022/10/6.
//

import UIKit

import SnapKit
import ThemeKit

public class StackComponent: UIView {
    // MARK: Properties

    public let stackView = UIStackView()

    // MARK: Lifecycle

    public init(centered: Bool) {
        super.init(frame: .zero)

        addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            if centered {
                maker.leading.trailing.equalToSuperview()
                maker.centerY.equalToSuperview()
            } else {
                maker.edges.equalToSuperview()
            }
        }
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
