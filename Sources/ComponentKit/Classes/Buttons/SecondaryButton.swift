//
//  SecondaryButton.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/19.
//

import UIKit

import SnapKit
import ThemeKit

// MARK: - SecondaryButton

open class SecondaryButton: ComponentButton {

    public enum Style {
        case `default`
        case transparent
        case transparent2
        case transparent3
        case tab
    }
    
    public init() {
        super.init(imagePosition: .left, spacing: 0)
    }
    
    override open func setup() {
        super.setup()
        
        layer.cornerCurve = .continuous
        semanticContentAttribute = .forceRightToLeft

        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .horizontal)

        snp.makeConstraints { maker in
            maker.height.equalTo(Self.height(style: .default))
        }
    }
    
    public func set(style: Style, imagePosition: ImagePosition = .left, image: UIImage? = nil) {
        let height = Self.height(style: style)
        self.imagePosition = imagePosition
        
        if case .transparent3 = style {
            // do nothings
        } else {
            snp.updateConstraints { maker in
                maker.height.equalTo(height)
            }
        }

        switch style {
        case .default, .transparent, .tab:
            cornerRadius = height / 2
        case .transparent2, .transparent3:
            cornerRadius = 0
        }

        titleLabel?.font = Self.font(style: style)

        switch style {
        case .default:
            setBackgroundColor(.jd016.alpha(0.2), for: .normal)
            setBackgroundColor(.jd016.alpha(0.1), for: .highlighted)
            setBackgroundColor(.jd016.alpha(0.2), for: .disabled)
            setBackgroundColor(.cg005, for: .selected)
            setBackgroundColor(.cg005.alpha(0.5), for: [.selected, .highlighted])
            
        case .transparent:
            setBackgroundColor(.clear, for: .normal)
            setBackgroundColor(.clear, for: .highlighted)
            setBackgroundColor(.clear, for: .disabled)
            setBackgroundColor(.cg005, for: .selected)
            setBackgroundColor(.cg005.alpha(0.5), for: [.selected, .highlighted])
            
        case .transparent2, .transparent3, .tab:
            setBackgroundColor(.clear, for: .normal)
            setBackgroundColor(.clear, for: .highlighted)
            setBackgroundColor(.clear, for: .disabled)
            setBackgroundColor(.clear, for: .selected)
            setBackgroundColor(.clear, for: [.selected, .highlighted])
        }

        switch style {
        case .default, .transparent:
            setTitleColor(.zx001, for: .normal)
            setTitleColor(.zx002, for: .highlighted)
            setTitleColor(.zx003, for: .disabled)
            setTitleColor(.zx017, for: .selected)
            setTitleColor(.zx017, for: [.selected, .highlighted])
            
        case .transparent2, .transparent3:
            setTitleColor(.zx001, for: .normal)
            setTitleColor(.zx003, for: .highlighted)
            setTitleColor(.zx005, for: .disabled)
            setTitleColor(.zx001, for: .selected)
            setTitleColor(.zx001.alpha(0.5), for: [.selected, .highlighted])
            
        case .tab:
            setTitleColor(.zx002, for: .normal)
            setTitleColor(.zx003, for: .highlighted)
            setTitleColor(.zx005, for: .disabled)
            setTitleColor(.zx001, for: .selected)
            setTitleColor(.zx001, for: [.selected, .highlighted])
        }

        let leftPadding = Self.leftPadding(style: style)
        let rightPadding = Self.rightPadding(style: style)
        let imagePadding = Self.imagePadding(style: style)

        if let image {
            switch style {
            case .default, .transparent, .tab:
                setImage(image.tint(.zx002), for: .normal)
                setImage(image.tint(.zx003), for: .highlighted)
                setImage(image.tint(.zx003), for: .disabled)
                setImage(image.tint(.zx017), for: .selected)
                setImage(image.tint(.zx017), for: [.selected, .highlighted])
                
            case .transparent2, .transparent3:
                setImage(image.tint(.zx002), for: .normal)
                setImage(image.tint(.zx005), for: .highlighted)
                setImage(image.tint(.zx005), for: .disabled)
                setImage(image.tint(.zx002), for: .selected)
                setImage(image.tint(.zx005), for: [.selected, .highlighted])
            }

            let verticalPadding = (height - CGFloat.iconSize20) / 2
            imageSpacing = imagePadding
            contentInsets = UIEdgeInsets(
                top: verticalPadding,
                left: leftPadding,
                bottom: verticalPadding,
                right: rightPadding
            )
            
        } else {
            imageSpacing = 0
            contentInsets = .only(left: leftPadding, right: rightPadding)
        }
    }
}

extension SecondaryButton {

    private static func font(style: Style) -> UIFont {
        switch style {
        case .default, .transparent:
            .captionM
        case .tab:
            .subhead1
        case .transparent2, .transparent3:
            .subhead2
        }
    }

    private static func leftPadding(style: Style) -> CGFloat {
        switch style {
        case .default, .transparent, .tab:
            .margin16
        case .transparent2, .transparent3:
            0
        }
    }

    private static func rightPadding(style: Style) -> CGFloat {
        switch style {
        case .default, .transparent, .tab:
            .margin16
        case .transparent2, .transparent3:
            0
        }
    }

    private static func imagePadding(style: Style) -> CGFloat {
        switch style {
        case .default, .transparent, .tab:
            .margin2
        case .transparent2, .transparent3:
            .margin8
        }
    }

    public static func height(style: Style) -> CGFloat {
        switch style {
        case .default, .transparent, .tab:
            28
        case .transparent2:
            20
        case .transparent3:
            0
        }
    }

    public static func width(title: String, style: Style, hasImage: Bool) -> CGFloat {
        var width = title.size(containerWidth: .greatestFiniteMagnitude, font: font(style: style)).width

        if hasImage {
            width += CGFloat.iconSize20 + imagePadding(style: style)
        }

        return width + leftPadding(style: style) + rightPadding(style: style)
    }

}
