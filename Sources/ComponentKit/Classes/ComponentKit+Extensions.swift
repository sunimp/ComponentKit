//
//  ComponentKit+Extensions.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/20.
//

import UIKit

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
        if self.contains([.top, .left]) { corners.append(.topLeft) }
        if self.contains([.top, .right]) { corners.append(.topRight) }
        if self.contains([.bottom, .left]) { corners.append(.bottomLeft) }
        if self.contains([.bottom, .right]) { corners.append(.bottomRight) }
        return corners
    }
}
