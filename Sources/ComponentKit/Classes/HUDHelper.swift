//
//  HUDHelper.swift
//  ComponentKit
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import HUD

// MARK: - HUDHelper

public class HUDHelper {
    // MARK: Nested Types

    private enum ImageType { case success, error, attention }

    // MARK: Static Properties

    public static let shared = HUDHelper()

    // MARK: Functions

    private func show(type: ImageType, title: String?, subtitle: String?) {
        let statusConfig = configStatusModel()

        let statusImage: UIImage?
        switch type {
        case .success: statusImage = ComponentKit.image(named: "checkmark_48")

        case .error:
            statusImage = ComponentKit.image(named: "close_48")
            statusConfig.imageTintColor = .zx001

        case .attention: statusImage = ComponentKit.image(named: "attention_48")
        }

        guard let image = statusImage else {
            return
        }

        HUD.shared.config = themeConfigHud()

        let textLength = (title?.count ?? 0) + (subtitle?.count ?? 0)
        let textReadDelay = min(max(1, Double(textLength) / 10), 3)

        statusConfig.dismissTimeInterval = textReadDelay

        HUDStatusFactory.shared.config = statusConfig

        let content = HUDStatusFactory.shared.view(type: .custom(image), title: title, subtitle: subtitle)
        HUD.shared.showHUD(content, onTapHUD: { hud in
            hud.hide()
        })
    }

    private func themeConfigHud() -> HUDConfig {
        var config = HUDConfig()
        config.style = .center
        config.appearStyle = .alphaAppear
        config.startAdjustSize = 0.8
        config.finishAdjustSize = 0.8
        config.preferredSize = CGSize(width: 146, height: 114)
        config.backgroundColor = .zx009.alpha(0.4)
        config.blurEffectStyle = .themeHud

        return config
    }

    private func configStatusModel() -> HUDStatusModel {
        let config = HUDStatusFactory.shared.config
        config.titleLabelFont = .subhead1
        config.titleLabelColor = .zx001

        config.subtitleLabelFont = .subhead1
        config.subtitleLabelColor = .zx002

        return config
    }
}

extension HUDHelper {
    public func showSuccess(title: String? = nil, subtitle: String? = nil) {
        show(type: .success, title: title, subtitle: subtitle)
    }

    public func showError(title: String? = nil, subtitle: String? = nil) {
        show(type: .error, title: title, subtitle: subtitle)
    }

    public func showAttention(title: String? = nil, subtitle: String? = nil) {
        show(type: .attention, title: title, subtitle: subtitle)
    }

    public func showSuccessBanner(title: String) {
        show(banner: .success(title: title))
    }

    public func showErrorBanner(title: String) {
        show(banner: .error(string: title))
    }

    public func showSpinner(title: String? = nil, userInteractionEnabled: Bool = false) {
        var customConfig = themeConfigHud()
        customConfig.hapticType = nil
        customConfig.userInteractionEnabled = userInteractionEnabled

        HUD.shared.config = customConfig

        let statusConfig = configStatusModel()

        statusConfig.dismissTimeInterval = nil
        statusConfig.customShowCancelInterval = nil

        HUDStatusFactory.shared.config = statusConfig

        let activityView = HUDActivityView.create(with: .large48)
        activityView.snp.removeConstraints()

        var titleLabel: UILabel?
        if let title {
            titleLabel = UILabel()
            titleLabel?.font = statusConfig.titleLabelFont
            titleLabel?.textColor = statusConfig.titleLabelColor
            titleLabel?.numberOfLines = statusConfig.titleLabelLinesCount
            titleLabel?.textAlignment = statusConfig.titleLabelAlignment
            titleLabel?.text = title
        }

        let content = HUDStatusView(
            frame: .zero,
            imageView: activityView,
            titleLabel: titleLabel,
            subtitleLabel: nil,
            config: statusConfig
        )
        HUD.shared.showHUD(content, onTapHUD: { hud in
            hud.hide()
        })

        activityView.startAnimating()
    }

    public func hide() {
        HUD.shared.hide()
    }
}

extension HUDHelper {
    private func show(banner: BannerType) {
        var config = HUDConfig()

        config.style = .banner(.top)
        config.appearStyle = .moveOut
        config.userInteractionEnabled = banner.isUserInteractionEnabled
        config.preferredSize = CGSize(width: 114, height: 56)

        config.coverBlurEffectStyle = nil
        config.coverBlurEffectIntensity = nil
        config.coverBackgroundColor = .zx010.alpha(0.5)

        config.blurEffectStyle = .themeHud
        config.backgroundColor = .zx010.alpha(0.2)
        config.blurEffectIntensity = 0.4

        config.cornerRadius = 28

        let viewItem = HUD.ViewItem(
            icon: banner.icon,
            iconColor: banner.color,
            title: banner.title,
            showingTime: banner.showingTime,
            isLoading: banner.isLoading
        )

        HUD.shared.show(config: config, viewItem: viewItem, forced: banner.forced)
    }

    private enum BannerType {
        case success(title: String)
        case error(string: String)

        // MARK: Computed Properties

        var icon: UIImage? {
            let image: UIImage? =
                switch self {
                case .success: UIImage(named: "circle_check_24")
                case .error: UIImage(named: "warning_2_24")
                }
            return image?.withRenderingMode(.alwaysTemplate)
        }

        var color: UIColor {
            switch self {
            case .error: .cg002
            case .success: .cg001
            }
        }

        var title: String {
            switch self {
            case let .success(title): title
            case let .error(description): description
            }
        }

        var showingTime: TimeInterval? {
            2
        }

        var isLoading: Bool {
            false
        }

        var isUserInteractionEnabled: Bool {
            true
        }

        var forced: Bool {
            true
        }
    }
}
