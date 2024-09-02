//
//  TransactionImageComponent.swift
//
//  Created by Sun on 2022/10/6.
//

import UIKit

import HUD
import Kingfisher
import SnapKit
import ThemeKit

// MARK: - TransactionImageComponent

public class TransactionImageComponent: UIView {
    // MARK: Properties

    private let spinner = HUDProgressView(
        progress: 0,
        strokeLineWidth: 2,
        radius: 21,
        strokeColor: .zx003,
        donutColor: .zx005.alpha(0.5),
        duration: 2
    )

    private let imageView = UIImageView()

    private let doubleImageWrapper = UIView()
    private let backImageView = UIImageView()
    private let frontImageMask = UIView()
    private let frontImageView = UIImageView()

    // MARK: Lifecycle

    public init() {
        super.init(frame: .zero)

        addSubview(spinner)
        spinner.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.size.equalTo(44)
        }

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.center.equalTo(spinner)
            maker.size.equalTo(CGFloat.iconSize32)
        }

        imageView.cornerRadius = .cornerRadius4

        addSubview(doubleImageWrapper)
        doubleImageWrapper.snp.makeConstraints { maker in
            maker.center.equalTo(spinner)
            maker.width.equalTo(32)
            maker.height.equalTo(36)
        }

        doubleImageWrapper.addSubview(backImageView)
        backImageView.snp.makeConstraints { maker in
            maker.leading.top.equalToSuperview()
            maker.size.equalTo(CGFloat.iconSize24)
        }

        backImageView.contentMode = .scaleAspectFill

        doubleImageWrapper.addSubview(frontImageMask)
        doubleImageWrapper.addSubview(frontImageView)

        frontImageView.snp.makeConstraints { maker in
            maker.trailing.bottom.equalToSuperview()
            maker.size.equalTo(CGFloat.iconSize24)
        }

        frontImageView.contentMode = .scaleAspectFill

        frontImageMask.snp.makeConstraints { maker in
            maker.size.equalTo(frontImageView)
            maker.center.equalTo(frontImageView).offset(-1)
        }

        frontImageMask.backgroundColor = .zx009
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    public func set(progress: Float?) {
        if let progress {
            spinner.isHidden = false
            spinner.set(progress: progress)
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
            spinner.isHidden = true
        }
    }

    public func set(image: UIImage?, contentMode: UIView.ContentMode = .scaleAspectFill) {
        doubleImageWrapper.isHidden = true
        imageView.isHidden = false

        imageView.contentMode = contentMode
        imageView.image = image
    }

    public func setImage(urlString: String?, placeholder: UIImage?) {
        doubleImageWrapper.isHidden = true
        imageView.isHidden = false

        imageView.contentMode = .scaleAspectFill
        imageView.image = nil
        imageView.kf.setImage(
            with: urlString.flatMap { URL(string: $0) },
            placeholder: placeholder,
            options: [.onlyLoadFirstFrame, .transition(.fade(0.5))]
        )
    }

    public func setDoubleImage(
        frontType: ImageType,
        frontURL: String?,
        frontPlaceholder: UIImage?,
        backType: ImageType,
        backURL: String?,
        backPlaceholder: UIImage?
    ) {
        imageView.isHidden = true
        doubleImageWrapper.isHidden = false

        switch frontType {
        case .circle:
            frontImageView.cornerRadius = CGFloat.iconSize24 / 2
            frontImageMask.cornerRadius = CGFloat.iconSize24 / 2

        case .squircle:
            frontImageView.cornerRadius = .cornerRadius4
            frontImageMask.cornerRadius = .cornerRadius4
        }

        switch backType {
        case .circle:
            backImageView.cornerRadius = CGFloat.iconSize24 / 2
        case .squircle:
            backImageView.cornerRadius = .cornerRadius4
        }

        frontImageView.image = nil
        backImageView.image = nil

        frontImageView.kf.setImage(
            with: frontURL.flatMap { URL(string: $0) },
            placeholder: frontPlaceholder,
            options: [.onlyLoadFirstFrame, .transition(.fade(0.5))]
        )
        backImageView.kf.setImage(
            with: backURL.flatMap { URL(string: $0) },
            placeholder: backPlaceholder,
            options: [.onlyLoadFirstFrame, .transition(.fade(0.5))]
        )
    }
}

// MARK: TransactionImageComponent.ImageType

extension TransactionImageComponent {
    public enum ImageType {
        case circle
        case squircle
    }
}
