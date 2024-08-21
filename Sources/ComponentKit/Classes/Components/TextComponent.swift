//
//  TextComponent.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/20.
//

import UIKit

import ThemeKit
import SnapKit

public class TextComponent: UILabel {

    public static func height(width: CGFloat, font: UIFont, text: String) -> CGFloat {
        text.height(forContainerWidth: width, font: font)
    }

    public static func width(font: UIFont, text: String) -> CGFloat {
        text.size(containerWidth: CGFloat.greatestFiniteMagnitude, font: font).width
    }

}
