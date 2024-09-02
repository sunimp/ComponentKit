//
//  SubtitleHeaderFooterView.swift
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import SnapKit
import ThemeKit

// MARK: - SubtitleHeaderFooterView

open class SubtitleHeaderFooterView: UITableViewHeaderFooterView {
    // MARK: Properties

    private let label = UILabel()

    // MARK: Lifecycle

    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        backgroundView = UIView()

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(CGFloat.margin32)
            maker.centerY.equalToSuperview()
        }

        label.font = .subhead1
        label.textColor = .zx003
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    open func bind(text: String?, backgroundColor: UIColor = .clear) {
        label.text = text?.uppercased()
        backgroundView?.backgroundColor = backgroundColor
    }
}

extension SubtitleHeaderFooterView {
    public static let height: CGFloat = .margin32
}
