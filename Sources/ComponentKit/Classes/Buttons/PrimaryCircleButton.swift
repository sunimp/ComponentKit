//
//  PrimaryCircleButton.swift
//  ComponentKit
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import SnapKit
import ThemeKit

open class PrimaryCircleButton: ComponentButton {
    // MARK: Nested Types

    public enum Style {
        case blue
        case red
        case gray
    }

    // MARK: Static Properties

    public static let size: CGFloat = .heightButton

    // MARK: Properties

    private var style: Style?

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

    public func set(image: UIImage?) {
        guard let style else {
            setImage(image?.tint(.zx001), for: .normal)
            setImage(image?.tint(.zx003), for: .highlighted)
            setImage(image?.tint(.zx005), for: .disabled)
            return
        }
        switch style {
        case .blue,
             .red:
            setImage(image?.tint(.zx017), for: .normal)
            setImage(image?.tint(.zx017), for: .highlighted)
            setImage(image?.tint(.zx017.alpha(0.5)), for: .disabled)
            
        case .gray:
            setImage(image?.tint(.zx001), for: .normal)
            setImage(image?.tint(.zx003), for: .highlighted)
            setImage(image?.tint(.zx005), for: .disabled)
        }
    }

    public func set(style: Style) {
        self.style = style

        switch style {
        case .blue:
            setImage(imageView?.image?.tint(.cg005), for: .normal)
            setBackgroundColor(.cg005, for: .normal)
            setBackgroundColor(.cg005.alpha(0.5), for: .highlighted)
            setBackgroundColor(.cg005.alpha(0.2), for: .disabled)

        case .red:
            setBackgroundColor(.jd003, for: .normal)
            setBackgroundColor(.jd003.alpha(0.5), for: .highlighted)
            setBackgroundColor(.jd003.alpha(0.2), for: .disabled)
            
        case .gray:
            setBackgroundColor(.zx007, for: .normal)
            setBackgroundColor(.zx008, for: .highlighted)
            setBackgroundColor(.zx007.alpha(0.2), for: .disabled)
        }
    }
}
