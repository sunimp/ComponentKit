//
//  SecondaryCircleButton.swift
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import SnapKit
import ThemeKit

open class SecondaryCircleButton: ComponentButton {
    // MARK: Nested Types

    public enum Style {
        case `default`
        case transparent
        case red
    }

    // MARK: Static Properties

    public static let size: CGFloat = 28

    // MARK: Lifecycle

    public init() {
        super.init(imagePosition: .left, spacing: 0)
    }

    // MARK: Overridden Functions

    override open func setup() {
        super.setup()
        
        cornerRadius = Self.size / 2

        snp.makeConstraints { maker in
            maker.size.equalTo(Self.size)
        }
    }

    // MARK: Functions

    public func set(image: UIImage?, style: Style = .default) {
        switch style {
        case .default,
             .red:
            setBackgroundColor(.zx005.alpha(0.5), for: .normal)
            setBackgroundColor(.zx006, for: .highlighted)
            setBackgroundColor(.zx007, for: .disabled)
            
        case .transparent:
            setBackgroundColor(.clear, for: .normal)
            setBackgroundColor(.clear, for: .highlighted)
            setBackgroundColor(.clear, for: .disabled)
        }

        switch style {
        case .default:
            setImage(image?.tint(.zx001), for: .normal)
            setImage(image?.tint(.zx002), for: .highlighted)
            setImage(image?.tint(.zx004), for: .disabled)
            setImage(image?.tint(.cg005), for: .selected)
            setImage(image?.tint(.cg005.alpha(0.7)), for: [.selected, .highlighted])
            
        case .transparent:
            setImage(image?.tint(.zx003), for: .normal)
            setImage(image?.tint(.zx005), for: .highlighted)
            setImage(image?.tint(.zx005), for: .disabled)
            setImage(image?.tint(.zx001), for: .selected)
            setImage(image?.tint(.zx003), for: [.selected, .highlighted])
            
        case .red:
            setImage(image?.tint(.jd003), for: .normal)
            setImage(image?.tint(.jd003.alpha(0.5)), for: .highlighted)
            setImage(image?.tint(.zx005), for: .disabled)
            setImage(image?.tint(.cg005), for: .selected)
            setImage(image?.tint(.cg005.alpha(0.5)), for: [.selected, .highlighted])
        }
    }
}
