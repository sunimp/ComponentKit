//
//  TopDescriptionHeaderFooterView.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/19.
//

import UIKit

import SnapKit
import ThemeKit

// MARK: - TopDescriptionHeaderFooterView

open class TopDescriptionHeaderFooterView: UITableViewHeaderFooterView {
    
    private let descriptionView = TopDescriptionView()

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

    open func bind(text: String?) {
        descriptionView.bind(text: text)
    }

}

extension TopDescriptionHeaderFooterView {

    public static func height(containerWidth: CGFloat, text: String) -> CGFloat {
        TopDescriptionView.height(containerWidth: containerWidth, text: text)
    }

}
