//
//  TopDescriptionHeaderFooterView.swift
//  ComponentKit
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import SnapKit
import ThemeKit

// MARK: - TopDescriptionHeaderFooterView

open class TopDescriptionHeaderFooterView: UITableViewHeaderFooterView {
    // MARK: Properties

    private let descriptionView = TopDescriptionView()

    // MARK: Lifecycle

    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.addSubview(descriptionView)
        descriptionView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().priority(.high)
        }
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    open func bind(text: String?) {
        descriptionView.bind(text: text)
    }
}

extension TopDescriptionHeaderFooterView {
    public static func height(containerWidth: CGFloat, text: String) -> CGFloat {
        TopDescriptionView.height(containerWidth: containerWidth, text: text)
    }
}
