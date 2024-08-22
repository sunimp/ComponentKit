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

open class PrimaryButton: UIButton {
    
    public enum Style {
        case blue
        case red
        case gray
        case transparent
    }
    
    public enum AccessoryType {
        case icon(image: UIImage?)
        case spinner
        case none
    }

    private static let horizontalPadding: CGFloat = .margin16
    private static let leftPaddingWithImage: CGFloat = .margin16
    private static let rightPaddingWithImage: CGFloat = .margin20
    private static let imageMargin: CGFloat = .margin8
    
    public static let height: CGFloat = .heightButton
    
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
    
    public init() {
        super.init(frame: .zero)
        
        cornerRadius = Self.height / 2
        layer.cornerCurve = .continuous
        
        titleLabel?.font = .headline2
        
        snp.makeConstraints { make in
            make.height.equalTo(Self.height)
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

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func set(style: Style, accessoryType: AccessoryType = .none) {
        self.style = style
        switch style {
        case .blue:
            setBackgroundColor(
                .jd009,
                gradient: ([.jd009, .jd010], direction: .leftToRight),
                for: .normal
            )
            setBackgroundColor(
                .jd009.alpha(0.5),
                gradient: ([.jd009.alpha(0.5), .jd010.alpha(0.5)], direction: .leftToRight),
                for: .highlighted
            )
            setBackgroundColor(
                .jd009.alpha(0.2),
                gradient: ([.jd009.alpha(0.2), .jd010.alpha(0.2)], direction: .leftToRight),
                for: .disabled
            )
            
        case .red:
            setBackgroundColor(.cg002, for: .normal)
            setBackgroundColor(.cg002.alpha(0.5), for: .highlighted)
            setBackgroundColor(.cg002.alpha(0.2), for: .disabled)
            
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
        case .blue, .red:
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
        case .icon(let image):
            switch style {
            case .blue, .red:
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

            let verticalPadding = (self.height - CGFloat.iconSize24) / 2
            imageEdgeInsets = .only(right: Self.imageMargin)
            contentEdgeInsets = UIEdgeInsets(
                top: verticalPadding,
                left: Self.leftPaddingWithImage,
                bottom: verticalPadding,
                right: Self.rightPaddingWithImage
            )
            
            spinner.isHidden = true
            spinner.stopAnimating()
            
        case .spinner:
            setImage(nil, for: .normal)
            setImage(nil, for: .highlighted)
            setImage(nil, for: .disabled)

            imageEdgeInsets = .zero
            contentEdgeInsets = UIEdgeInsets(
                top: 0,
                left: Self.leftPaddingWithImage + .iconSize24 + Self.imageMargin,
                bottom: 0,
                right: Self.rightPaddingWithImage
            )
            
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
        case .blue, .red:
            spinner.set(strokeColor: isEnabled ? .zx017 : .zx017.alpha(0.5))
            
        case .gray:
            spinner.set(strokeColor: isEnabled ? .cg005 : .cg005.alpha(0.5))
            
        case .transparent:
            spinner.set(strokeColor: isEnabled ? (isHighlighted ? .zx003 : .zx001) : .zx005)
        }
    }
}
