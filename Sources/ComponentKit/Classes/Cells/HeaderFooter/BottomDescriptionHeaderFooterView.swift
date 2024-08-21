//
//  BottomDescriptionHeaderFooterView.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/19.
//

import UIKit

import ThemeKit
import SnapKit

open class BottomDescriptionHeaderFooterView: UITableViewHeaderFooterView {
    
    private let descriptionView = BottomDescriptionView()

    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.addSubview(descriptionView)
        descriptionView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().priority(.high)
        }
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
) -> CGFloat {
        BottomDescriptionView.height(
            containerWidth: containerWidth,
            text: text,
            topMargin: topMargin, 
            bottomMargin: bottomMargin
        )
    }

}
