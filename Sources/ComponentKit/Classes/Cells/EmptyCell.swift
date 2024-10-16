//
//  EmptyCell.swift
//  ComponentKit
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import SnapKit
import ThemeKit

open class EmptyCell: UITableViewCell {
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        selectionStyle = .none
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
