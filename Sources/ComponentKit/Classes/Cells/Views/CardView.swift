//
//  CardView.swift
//  ComponentKit
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import SnapKit
import ThemeKit

open class CardView: UIView {
    // MARK: Properties

    public let contentView = UIView()

    private let roundedBackground = UIView()
    private let clippingView = UIView()

    // MARK: Lifecycle

    public init(insets: UIEdgeInsets) {
        super.init(frame: .zero)

        addSubview(roundedBackground)
        roundedBackground.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        roundedBackground.backgroundColor = .zx009
        roundedBackground.layer.cornerRadius = .cornerRadius16
        roundedBackground.layer.cornerCurve = .continuous

        addSubview(clippingView)
        clippingView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        clippingView.backgroundColor = .clear
        clippingView.clipsToBounds = true
        clippingView.layer.cornerRadius = .cornerRadius16
        clippingView.layer.cornerCurve = .continuous

        clippingView.addSubview(contentView)
        contentView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(insets)
        }

        contentView.backgroundColor = .clear

        updateUI()
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overridden Functions

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        updateUI()
    }

    // MARK: Functions

    private func updateUI() {
        roundedBackground.layer.shadowColor = UIColor.zx003.cgColor
    }
}
