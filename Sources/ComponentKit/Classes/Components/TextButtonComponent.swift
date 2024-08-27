//
//  TextButtonComponent.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/20.
//

import UIKit

import SnapKit
import ThemeKit

// MARK: - TextButtonComponent

public class TextButtonComponent: UIButton {
    
    public var onTap: (() -> Void)?

    public var font: UIFont? {
        get { titleLabel?.font }
        set { titleLabel?.font = newValue }
    }
    
    public var textColor: UIColor? {
        get { titleColor(for: .normal) }
        set { setTitleColor(newValue, for: .normal) }
    }
    
    public var text: String? {
        get { title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }
    
    override public var intrinsicContentSize: CGSize {
        titleLabel?.intrinsicContentSize ?? super.intrinsicContentSize
    }

    public init() {
        super.init(frame: .zero)

        addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func handleTap() {
        onTap?()
    }
}

extension TextButtonComponent {

    public static func height(width: CGFloat, font: UIFont, text: String) -> CGFloat {
        text.height(forContainerWidth: width, font: font)
    }

    public static func width(font: UIFont, text: String) -> CGFloat {
        text.size(containerWidth: CGFloat.greatestFiniteMagnitude, font: font).width
    }

}
