//
//  SpinnerCell.swift
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import HUD
import SnapKit

open class SpinnerCell: UITableViewCell {
    // MARK: Properties

    private let spinner = HUDActivityView.create(with: .medium24)

    // MARK: Lifecycle

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(spinner)
        spinner.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }

        spinner.startAnimating()
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
