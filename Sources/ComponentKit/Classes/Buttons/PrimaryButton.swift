//
//  PrimaryButton.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/19.
//

import UIKit

import SnapKit
import ThemeKit
import HUD

open class PrimaryButton: ComponentButton {
    
    public enum Style {
        case blue
        case cyan
        case purple
        case blueGray
        case green
        case red
        case gray
        case transparent
    }
    
    public enum AccessoryType {
        
        case icon(image: UIImage?, position: ComponentButton.ImagePosition = .left(.margin8))
        case spinner(position: ComponentButton.ImagePosition = .left(.margin8))
        case none
    }

    private static let horizontalPadding: CGFloat = .margin16
    private static let leftPaddingWithImage: CGFloat = 14
    private static let rightPaddingWithImage: CGFloat = 26
    private static let imageMargin: CGFloat = .margin8
    
    private var style: Style = .transparent
    private let spinner = HUDActivityView.create(with: .medium24)

    public var isScaleHighlightedEnabled: Bool = true
    
    open override var isEnabled: Bool {
        didSet {
            updateSpinnerStrokeColor()
        }
    }
    
    open override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if !super.isHighlighted, newValue {
                self.scaleHighlightedAnimation(newValue)
            } else if super.isHighlighted, !newValue {
                self.scaleHighlightedAnimation(newValue)
            }
            super.isHighlighted = newValue
            updateSpinnerStrokeColor()
        }
    }
    
    open override func setup() {
        super.setup()
     
        self.cornerRadius = self.buttonHeight / 2
        self.layer.cornerCurve = .continuous

        titleLabel?.font = .medium15
        
        snp.makeConstraints { make in
            make.height.equalTo(self.buttonHeight)
        }
        
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            if let titleLabel {
                make.trailing.equalTo(titleLabel.snp.leading).offset(-Self.imageMargin)
            } else {
                make.leading.equalToSuperview().inset(Self.leftPaddingWithImage)
            }
            make.centerY.equalToSuperview()
        }
    }

    open func set(style: Style, accessoryType: AccessoryType = .none) {
        self.style = style
        switch style {
        case .blue, .green, .red, .cyan, .purple, .blueGray:
            let fromColor: UIColor
            let toColor: UIColor
            switch style {
            case .blue:
                fromColor = .jd009
                toColor = .jd010
            case .green:
                fromColor = .jd001
                toColor = .jd002
            case .red:
                fromColor = .cg002
                toColor = .cg002
            case .cyan:
                fromColor = .jd011
                toColor = .jd012
            case .purple:
                fromColor = .jd013
                toColor = .jd014
            case .blueGray:
                fromColor = .jd015
                toColor = .jd016
            default:
                fromColor = .zx009
                toColor = .zx008
            }
            setBackgroundColor(
                fromColor,
                gradient: ([fromColor, toColor], direction: .leftToRight),
                for: .normal
            )
            setBackgroundColor(
                fromColor.alpha(0.5),
                gradient: ([fromColor.alpha(0.5), toColor.alpha(0.5)], direction: .leftToRight),
                for: .highlighted
            )
            setBackgroundColor(
                fromColor.alpha(0.2),
                gradient: ([fromColor.alpha(0.2), toColor.alpha(0.2)], direction: .leftToRight),
                for: .disabled
            )
            
        case .gray:
            setBackgroundColor(.zx007, for: .normal)
            setBackgroundColor(.zx007.alpha(0.5), for: .highlighted)
            setBackgroundColor(.zx007.alpha(0.2), for: .disabled)
            
        case .transparent:
            setBackgroundColor(.clear, for: .normal)
            setBackgroundColor(.clear, for: .highlighted)
            setBackgroundColor(.clear, for: .disabled)
        }

        switch style {
        case .blue, .green, .red, .cyan, .purple, .blueGray:
            setTitleColor(.zx017, for: .normal)
            setTitleColor(.zx017, for: .highlighted)
            setTitleColor(.zx017.alpha(0.5), for: .disabled)
            
        case .gray:
            setTitleColor(.cg005, for: .normal)
            setTitleColor(.cg005, for: .highlighted)
            setTitleColor(.cg005.alpha(0.5), for: .disabled)
            
        case .transparent:
            setTitleColor(.zx001, for: .normal)
            setTitleColor(.zx003, for: .highlighted)
            setTitleColor(.zx005, for: .disabled)
        }

        switch accessoryType {
        case let .icon(image, position):
            switch style {
            case .blue, .green, .red, .cyan, .purple, .blueGray:
                setImage(image?.tint(.zx017), for: .normal)
                setImage(image?.tint(.zx017), for: .highlighted)
                setImage(image?.tint(.zx017.alpha(0.5)), for: .disabled)
                
            case .gray:
                setImage(image?.tint(.cg005), for: .normal)
                setImage(image?.tint(.cg005), for: .highlighted)
                setImage(image?.tint(.cg005.alpha(0.5)), for: .disabled)
                
            case .transparent:
                setImage(image?.tint(.zx001), for: .normal)
                setImage(image?.tint(.zx003), for: .highlighted)
                setImage(image?.tint(.zx005), for: .disabled)
            }

            let verticalPadding = (self.buttonHeight - CGFloat.iconSize24) / 2
            contentEdgeInsets = UIEdgeInsets(
                top: verticalPadding,
                left: Self.leftPaddingWithImage,
                bottom: verticalPadding,
                right: Self.rightPaddingWithImage
            )
            self.imagePosition = position
            spinner.isHidden = true
            spinner.stopAnimating()
            
        case .spinner(let position):
            setImage(nil, for: .normal)
            setImage(nil, for: .highlighted)
            setImage(nil, for: .disabled)

            contentEdgeInsets = UIEdgeInsets(
                top: 0,
                left: Self.leftPaddingWithImage + .iconSize24 + Self.imageMargin,
                bottom: 0,
                right: Self.rightPaddingWithImage
            )
            self.imagePosition = position
            spinner.isHidden = false
            spinner.startAnimating()
            
        case .none:
            setImage(nil, for: .normal)
            setImage(nil, for: .highlighted)
            setImage(nil, for: .disabled)

            imageEdgeInsets = .zero
            contentEdgeInsets = UIEdgeInsets(
                top: 0, 
                left: Self.horizontalPadding,
                bottom: 0,
                right: Self.horizontalPadding
            )
            spinner.isHidden = true
            spinner.stopAnimating()
        }
        
        updateSpinnerStrokeColor()
    }
    
    open func scaleHighlightedAnimation(_ isHighlighted: Bool) {
        guard self.isScaleHighlightedEnabled else { return }
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        let ratio: Float = 0.96
        animation.fromValue = isHighlighted ? 1 : ratio
        animation.toValue = isHighlighted ? ratio : 1
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        animation.duration = 0.24
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.33, 0, 0.67, 1)
        
        let key = "highlight_Animation_Transform.scale"
        self.layer.removeAnimation(forKey: key)
        self.layer.add(animation, forKey: key)
    }

    private func updateSpinnerStrokeColor() {
        guard !spinner.isHidden else {
            return
        }
        switch style {
        case .blue, .green, .red, .cyan, .purple, .blueGray:
            spinner.set(strokeColor: isEnabled ? .zx017 : .zx017.alpha(0.5))
            
        case .gray:
            spinner.set(strokeColor: isEnabled ? .cg005 : .cg005.alpha(0.5))
            
        case .transparent:
            spinner.set(strokeColor: isEnabled ? (isHighlighted ? .zx003 : .zx001) : .zx005)
        }
    }
}
