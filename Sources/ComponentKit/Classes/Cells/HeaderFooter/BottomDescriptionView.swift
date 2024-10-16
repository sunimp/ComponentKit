//
//  BottomDescriptionView.swift
//  ComponentKit
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import SnapKit
import ThemeKit

// MARK: - BottomDescriptionView

open class BottomDescriptionView: UIView {
    // MARK: Static Properties

    private static let sideMargin: CGFloat = .margin32
    private static let font: UIFont = .subhead2

    // MARK: Properties

    private let label = UILabel()

    // MARK: Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)

        label.numberOfLines = 0
        label.font = BottomDescriptionView.font
        label.textColor = .zx003

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(BottomDescriptionView.sideMargin)
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
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
        label.text = text
        label.textColor = textColor

        label.snp.remakeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(Self.sideMargin)
            maker.top.equalToSuperview().offset(topMargin)
            maker.bottom.equalToSuperview().inset(bottomMargin)
        }
    }
}

extension BottomDescriptionView {
    public static func height(
        containerWidth: CGFloat,
        text: String,
        topMargin: CGFloat = .margin12,
        bottomMargin: CGFloat = .margin32
    )
        -> CGFloat {
        let textHeight = text.height(
            forContainerWidth: containerWidth - 2 * BottomDescriptionView.sideMargin,
            font: BottomDescriptionView.font
        )
        return textHeight + topMargin + bottomMargin
    }
}
