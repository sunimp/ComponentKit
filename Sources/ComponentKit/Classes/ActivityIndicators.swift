//
//  ActivityIndicators.swift
//  ComponentKit
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import HUD
import ThemeKit

// MARK: - ActivityIndicatorStyle

public enum ActivityIndicatorStyle {
    case small20
    case medium24
    case large48

    // MARK: Computed Properties

    public var dashHeight: CGFloat {
        switch self {
        case .small20:
            4
        case .medium24:
            5
        case .large48:
            10
        }
    }

    public var dashStrokeWidth: CGFloat {
        switch self {
        case .small20:
            1 + .heightOnePixel
        case .medium24:
            2
        case .large48:
            4
        }
    }

    public var radius: CGFloat {
        switch self {
        case .small20:
            8
        case .medium24:
            10
        case .large48:
            20
        }
    }

    public var edgeInsets: UIEdgeInsets {
        switch self {
        case .small20:
            UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        case .medium24:
            UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        case .large48:
            UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        }
    }

    public var size: CGFloat {
        switch self {
        case .small20:
            20
        case .medium24:
            24
        case .large48:
            48
        }
    }
}

extension HUDActivityView {
    public static func create(with style: ActivityIndicatorStyle, strokeColor: UIColor = .gray) -> HUDActivityView {
        let activityView = HUDActivityView(
            dashHeight: style.dashHeight,
            dashStrokeWidth: style.dashStrokeWidth,
            radius: style.radius,
            strokeColor: strokeColor,
            duration: 0.834
        )
        activityView.edgeInsets = style.edgeInsets

        activityView.snp.makeConstraints { maker in
            maker.size.equalTo(style.size)
        }

        return activityView
    }
}
