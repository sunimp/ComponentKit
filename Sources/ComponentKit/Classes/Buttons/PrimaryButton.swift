//
//  PrimaryButton.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/19.
//

import UIKit

import SnapKit
import ThemeKit
import UIExtensions
import HUD

open class PrimaryButton: ComponentButton {
    
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

    public static let height: CGFloat = .heightButton
    
    private var style: Style = .transparent
    private let spinnerStyle: ActivityIndicatorStyle = .medium24
    private lazy var spinner = HUDActivityView.create(with: spinnerStyle)

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
        super.init(imagePosition: .left, spacing: 0)
    }
    
    override open func setup() {
        super.setup()
        
        layer.cornerCurve = .continuous
        
        titleLabel?.font = .headline2
        
        snp.makeConstraints { make in
            make.height.equalTo(Self.height)
        }
        
        addSubview(spinner)
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
        
        let titleColor: (normal: UIColor, highlighted: UIColor, disabled: UIColor)
        switch style {
        case .blue, .red:
            titleColor = (.zx017, .zx017, .zx017.alpha(0.5))
        case .gray:
            titleColor = (.cg005, .cg005, .cg005.alpha(0.5))
        case .transparent:
            titleColor = (.zx001, .zx003, .zx005)
        }
        
        setTitleColor(titleColor.normal, for: .normal)
        setTitleColor(titleColor.highlighted, for: .highlighted)
        setTitleColor(titleColor.disabled, for: .disabled)

        switch accessoryType {
        case .icon(let image):
            setImage(image?.tint(titleColor.normal), for: .normal)
            setImage(image?.tint(titleColor.highlighted), for: .highlighted)
            setImage(image?.tint(titleColor.disabled), for: .disabled)

            let verticalPadding = (Self.height - CGFloat.iconSize24) / 2
            imageSpacing = .margin8
            contentInsets = .symmetric(
                vertical: verticalPadding,
                horizontal: .margin16
            )
            cornerRadius = Self.height / 2
            spinner.isHidden = true
            spinner.stopAnimating()
            
        case .spinner:
            setImage(nil, for: .normal)
            setImage(nil, for: .highlighted)
            setImage(nil, for: .disabled)

            imageSpacing = 0
            switch imagePosition {
            case .left:
                contentInsets = .only(
                    left: CGFloat.margin16 + .iconSize24 + .margin8,
                    right: .margin16
                )
                snp.updateConstraints { make in
                    make.height.equalTo(Self.height)
                }
                spinner.snp.remakeConstraints { make in
                    if let titleLabel, titleLabel.superview != nil {
                        make.trailing.equalTo(titleLabel.snp.leading).offset(-CGFloat.margin8)
                    } else {
                        make.leading.equalToSuperview().inset(CGFloat.margin16)
                    }
                    make.centerY.equalToSuperview()
                    make.size.equalTo(self.spinnerStyle.size)
                }
                cornerRadius = Self.height / 2
                
            case .right:
                contentInsets = .only(
                    left: .margin16,
                    right: CGFloat.margin16 + .iconSize24 + .margin8
                )
                snp.updateConstraints { make in
                    make.height.equalTo(Self.height)
                }
                spinner.snp.remakeConstraints { make in
                    if let titleLabel, titleLabel.superview != nil {
                        make.leading.equalTo(titleLabel.snp.trailing).offset(CGFloat.margin8)
                    } else {
                        make.trailing.equalToSuperview().inset(CGFloat.margin16)
                    }
                    make.centerY.equalToSuperview()
                    make.size.equalTo(self.spinnerStyle.size)
                }
                cornerRadius = Self.height / 2
                
            case .top:
                contentInsets = .only(
                    top: CGFloat.margin12 + .iconSize24 + .margin4,
                    left: .margin16,
                    right: .margin16
                )
                snp.updateConstraints { make in
                    make.height.equalTo(Self.height + .iconSize24 + .margin4)
                }
                spinner.snp.remakeConstraints { make in
                    make.top.equalToSuperview().inset(CGFloat.margin12)
                    make.centerX.equalToSuperview()
                    make.size.equalTo(self.spinnerStyle.size)
                }
                cornerRadius = (Self.height + .iconSize24 + .margin4) / 2
                
            case .bottom:
                contentInsets = .only(
                    left: .margin16,
                    bottom: CGFloat.margin12 + .iconSize24 + .margin4,
                    right: .margin16
                )
                snp.updateConstraints { make in
                    make.height.equalTo(Self.height + .iconSize24 + .margin4)
                }
                spinner.snp.remakeConstraints { make in
                    make.bottom.equalToSuperview().inset(CGFloat.margin12)
                    make.centerX.equalToSuperview()
                    make.size.equalTo(self.spinnerStyle.size)
                }
                cornerRadius = (Self.height + .iconSize24 + .margin4) / 2
            }
            
            spinner.isHidden = false
            spinner.startAnimating()
            
        case .none:
            setImage(nil, for: .normal)
            setImage(nil, for: .highlighted)
            setImage(nil, for: .disabled)
            
            imageSpacing = 0
            contentInsets = .symmetric(horizontal: .margin16)
            cornerRadius = Self.height / 2
            
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
