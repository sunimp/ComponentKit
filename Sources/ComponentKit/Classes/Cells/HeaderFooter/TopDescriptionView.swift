//
//  TopDescriptionView.swift
//  ComponentKit
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import SnapKit
import ThemeKit

// MARK: - TopDescriptionView

open class TopDescriptionView: UIView {
    // MARK: Static Properties

    private static let sideMargin: CGFloat = .margin6x
    private static let topMargin: CGFloat = .margin3x
    private static let bottomMargin: CGFloat = .margin6x
    private static let font: UIFont = .subhead2

    // MARK: Properties

    private let label = UILabel()

    // MARK: Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)

        label.numberOfLines = 0
        label.font = TopDescriptionView.font
        label.textColor = .zx003

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(TopDescriptionView.sideMargin)
            maker.top.equalToSuperview().offset(TopDescriptionView.topMargin)
            maker.bottom.equalToSuperview().inset(TopDescriptionView.bottomMargin)
        }
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    open func bind(text: String?) {
        label.text = text
    }
}

extension TopDescriptionView {
    public static func height(containerWidth: CGFloat, text: String) -> CGFloat {
        let textHeight = text.height(
            forContainerWidth: containerWidth - 2 * TopDescriptionView.sideMargin,
            font: TopDescriptionView.font
        )
        return textHeight + TopDescriptionView.topMargin + TopDescriptionView.bottomMargin
    }
}
