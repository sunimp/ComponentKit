//
//  SubtitleHeaderFooterView.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/19.
//

import UIKit

import SnapKit
import ThemeKit

open class SubtitleHeaderFooterView: UITableViewHeaderFooterView {
    
    private let label = UILabel()

    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        backgroundView = UIView()

        addSubview(label)
        label.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(CGFloat.margin32)
            maker.centerY.equalToSuperview()
        }

        label.font = .medium13
        label.textColor = .zx003
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(text: String?, backgroundColor: UIColor = .clear) {
        label.text = text?.uppercased()
        backgroundView?.backgroundColor = backgroundColor
    }

}

extension SubtitleHeaderFooterView {
    
    public static let height: CGFloat = .margin32
}
