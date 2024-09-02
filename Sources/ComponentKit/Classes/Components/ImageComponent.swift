//
//  ImageComponent.swift
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import Kingfisher
import SnapKit
import ThemeKit

public class ImageComponent: UIView {
    // MARK: Properties

    public let imageView = UIImageView()

    // MARK: Computed Properties

    public var imageRatio: CGFloat? {
        if let image = imageView.image {
            return image.size.height / image.size.width
        }
        
        return nil
    }

    // MARK: Lifecycle

    public init(size: CGFloat) {
        super.init(frame: .zero)

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.size.equalTo(size)
        }
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    public func setImage(urlString: String?, placeholder: UIImage?) {
        imageView.kf.setImage(
            with: urlString.flatMap { URL(string: $0) },
            placeholder: placeholder,
            options: [.scaleFactor(UIScreen.main.scale)]
        )
    }
}
