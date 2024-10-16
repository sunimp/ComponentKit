//
//  BottomDescriptionHeaderFooterView.swift
//  ComponentKit
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import SnapKit
import ThemeKit

// MARK: - BottomDescriptionHeaderFooterView

open class BottomDescriptionHeaderFooterView: UITableViewHeaderFooterView {
    // MARK: Properties

    private let descriptionView = BottomDescriptionView()

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

    public func bind(
        text: String,
        textColor: UIColor = .zx003,
        topMargin: CGFloat = .margin12,
        bottomMargin: CGFloat = .margin32
    ) {
        descriptionView.bind(text: text, textColor: textColor, topMargin: topMargin, bottomMargin: bottomMargin)
    }
}

extension BottomDescriptionHeaderFooterView {
    public static func height(
        containerWidth: CGFloat,
        text: String,
        topMargin: CGFloat = .margin12,
        bottomMargin: CGFloat = .margin32
    )
        -> CGFloat {
        BottomDescriptionView.height(
            containerWidth: containerWidth,
            text: text,
            topMargin: topMargin,
            bottomMargin: bottomMargin
        )
    }
}
