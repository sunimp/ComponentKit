//
//  SecondaryButton.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/19.
//

import UIKit

import ThemeKit
import SnapKit

open class SecondaryButton: UIButton {

    public init() {
        super.init(frame: .zero)
        
        layer.cornerCurve = .continuous
        semanticContentAttribute = .forceRightToLeft

        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .horizontal)

        snp.makeConstraints { maker in
            maker.height.equalTo(Self.height(style: .default))
        }
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(style: Style, image: UIImage? = nil) {
        let height = Self.height(style: style)

        snp.updateConstraints { maker in
            maker.height.equalTo(height)
        }

        switch style {
        case .default, .transparent, .tab: 
            cornerRadius = height / 2
        case .transparent2: 
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
            
        case .transparent2, .tab:
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
            
        case .transparent2:
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
        let rightPadding = Self.rightPadding(style: style, hasImage: image != nil)
        let imagePadding = Self.imagePadding(style: style)

        if let image = image {
            switch style {
            case .default, .transparent, .tab:
                setImage(image.tint(.zx002), for: .normal)
                setImage(image.tint(.zx003), for: .highlighted)
                setImage(image.tint(.zx003), for: .disabled)
                setImage(image.tint(.zx017), for: .selected)
                setImage(image.tint(.zx017), for: [.selected, .highlighted])
                
            case .transparent2:
                setImage(image.tint(.zx002), for: .normal)
                setImage(image.tint(.zx005), for: .highlighted)
                setImage(image.tint(.zx005), for: .disabled)
                setImage(image.tint(.zx002), for: .selected)
                setImage(image.tint(.zx005), for: [.selected, .highlighted])
            }

            let verticalPadding = (height - CGFloat.iconSize20) / 2
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imagePadding, bottom: 0, right: imagePadding)
            contentEdgeInsets = UIEdgeInsets(
                top: verticalPadding,
                left: leftPadding + imagePadding,
                bottom: verticalPadding,
                right: rightPadding
            )
            
        } else {
            titleEdgeInsets = .zero
            contentEdgeInsets = UIEdgeInsets(
                top: 0,
                left: leftPadding,
                bottom: 0,
                right: rightPadding
            )
        }
    }

    public enum Style {
        case `default`
        case transparent
        case transparent2
        case tab
    }

}

extension SecondaryButton {

    private static func font(style: Style) -> UIFont {
        switch style {
        case .default, .transparent: return .captionSB
        case .tab: return .subhead1
        case .transparent2: return .subhead2
        }
    }

    private static func leftPadding(style: Style) -> CGFloat {
        switch style {
        case .default, .transparent, .tab: return .margin16
        case .transparent2: return 0
        }
    }

    private static func rightPadding(style: Style, hasImage: Bool) -> CGFloat {
        switch style {
        case .default, .transparent: return hasImage ? .margin8 : .margin16
        case .tab: return .margin16
        case .transparent2: return 0
        }
    }

    private static func imagePadding(style: Style) -> CGFloat {
        switch style {
        case .default, .transparent, .tab: return .margin2
        case .transparent2: return .margin8
        }
    }

    public static func height(style: Style) -> CGFloat {
        switch style {
        case .default, .transparent, .tab: return 28
        case .transparent2: return 20
        }
    }

    public static func width(title: String, style: Style, hasImage: Bool) -> CGFloat {
        var width = title.size(containerWidth: .greatestFiniteMagnitude, font: font(style: style)).width

        if hasImage {
            width += CGFloat.iconSize20 + imagePadding(style: style)
        }

        return width + leftPadding(style: style) + rightPadding(style: style, hasImage: hasImage)
    }

}
