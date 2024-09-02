//
//  BadgeView.swift
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import SnapKit
import ThemeKit

// MARK: - BadgeView

public class BadgeView: UIView {
    // MARK: Static Properties

    private static let sideMargin: CGFloat = .margin6
    private static let spacing: CGFloat = .margin2

    // MARK: Properties

    private let stackView = UIStackView()
    private let label = UILabel()
    private let changeLabel = UILabel()

    // MARK: Computed Properties

    public var font: UIFont {
        get { label.font }
        set {
            label.font = newValue
            changeLabel.font = newValue
        }
    }
    
    public var textColor: UIColor {
        get { label.textColor }
        set { label.textColor = newValue }
    }
    
    public var text: String? {
        get { label.text }
        set { label.text = newValue }
    }
    
    public var change: Change? {
        didSet {
            changeLabel.isHidden = change == nil
            changeLabel.text = change?.text
            changeLabel.textColor = change?.color
        }
    }

    public var compressionResistance: UILayoutPriority = .required {
        didSet {
            label.setContentCompressionResistancePriority(compressionResistance, for: .horizontal)
        }
    }

    // MARK: Lifecycle

    override public init(frame: CGRect) {
        super.init(frame: frame)

        snp.makeConstraints { maker in
            maker.height.equalTo(0)
        }

        layer.cornerRadius = .cornerRadius8
        layer.cornerCurve = .continuous

        addSubview(stackView)
        stackView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(Self.sideMargin)
            maker.centerY.equalToSuperview()
        }

        stackView.spacing = Self.spacing
        stackView.alignment = .fill

        stackView.addArrangedSubview(label)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)

        stackView.addArrangedSubview(changeLabel)
        changeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        changeLabel.setContentHuggingPriority(.required, for: .horizontal)
        changeLabel.isHidden = true
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Static Functions

    public static func width(for text: String, change: Change?, style: Style) -> CGFloat {
        let textWidth = text.size(containerWidth: .greatestFiniteMagnitude, font: style.font).width
        let changeWidth = change
            .map { $0.text.size(containerWidth: .greatestFiniteMagnitude, font: style.font).width + spacing } ?? 0
        return textWidth + changeWidth + sideMargin * 2
    }

    // MARK: Functions

    public func set(style: Style) {
        backgroundColor = style.backgroundColor
        label.textColor = style.textColor
        label.font = style.font
        changeLabel.font = style.font

        snp.updateConstraints { maker in
            maker.height.equalTo(style.height)
        }
    }
}

extension BadgeView {
    public enum Style {
        case small
        case medium

        // MARK: Computed Properties

        var height: CGFloat {
            switch self {
            case .small: 15
            case .medium: 18
            }
        }

        var font: UIFont {
            switch self {
            case .small: .microM
            case .medium: .captionM
            }
        }

        var textColor: UIColor {
            switch self {
            case .small: .zx001
            case .medium: .zx017
            }
        }

        var backgroundColor: UIColor {
            switch self {
            case .small: .zx007
            case .medium: .cg002
            }
        }
    }

    public enum Change {
        case up(String)
        case down(String)

        // MARK: Computed Properties

        var color: UIColor {
            switch self {
            case .up: .cg003
            case .down: .cg004
            }
        }

        var text: String {
            switch self {
            case let .down(text): symbol + text
            case let .up(text): symbol + text
            }
        }

        private var symbol: String {
            switch self {
            case .up: "↑"
            case .down: "↓"
            }
        }
    }
}
