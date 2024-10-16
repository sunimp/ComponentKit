//
//  ComponentKit+Extensions.swift
//  ComponentKit
//
//  Created by Sun on 2021/12/1.
//

import UIKit

import Kingfisher

extension UIView {
    @IBInspectable
    open var cornerCurve: CALayerCornerCurve {
        get {
            layer.cornerCurve
        }
        set {
            layer.cornerCurve = newValue
        }
    }
}

extension UIRectEdge {
    var toArray: [UIRectEdge] {
        let all: [UIRectEdge] = [.top, .right, .bottom, .left]
        return all.filter { edge in contains(edge) }
    }

    var corners: [UIRectCorner] {
        var corners = [UIRectCorner]()
        if contains([.top, .left]) {
            corners.append(.topLeft)
        }
        if contains([.top, .right]) {
            corners.append(.topRight)
        }
        if contains([.bottom, .left]) {
            corners.append(.bottomLeft)
        }
        if contains([.bottom, .right]) {
            corners.append(.bottomRight)
        }
        return corners
    }
}

extension UIImageView {
    public func setImage(
        url urlString: String?,
        alternativeURL alternativeURLString: String? = nil,
        placeholder: UIImage? = nil
    ) {
        image = nil
        let options: [KingfisherOptionsInfoItem] = [.onlyLoadFirstFrame, .transition(.fade(0.5))]
        let url = urlString.flatMap { URL(string: $0) }
        if let alternativeURLString, let alternativeURL = URL(string: alternativeURLString) {
            if ImageCache.default.isCached(forKey: alternativeURLString) {
                kf.setImage(with: alternativeURL, placeholder: placeholder, options: options)
            } else {
                kf.setImage(
                    with: url,
                    placeholder: placeholder,
                    options: options + [.alternativeSources([.network(alternativeURL)])]
                )
            }
        } else {
            kf.setImage(with: url, placeholder: placeholder, options: options)
        }
    }
}
