//
//  CardView.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/19.
//

import UIKit

import ThemeKit
import SnapKit

open class CardView: UIView {
    
    private let roundedBackground = UIView()
    private let clippingView = UIView()
    public let contentView = UIView()

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
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        updateUI()
    }

    private func updateUI() {
        roundedBackground.layer.shadowColor = UIColor.zx003.cgColor
    }

}
