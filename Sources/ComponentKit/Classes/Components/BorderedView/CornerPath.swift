//
//  CornerPath.swift
//  ComponentKit
//
//  Created by Sun on 2022/10/6.
//

import UIKit

// MARK: - CornerPath

open class CornerPath {
    // MARK: Properties

    let lineWidth: CGFloat
    let offset: CGFloat
    let rect: CGRect
    let cornerRadius: CGFloat

    // MARK: Computed Properties

    open var cornerCoefficient: CGFloat { 1 }

    // MARK: Lifecycle

    public init(lineWidth: CGFloat, rect: CGRect, cornerRadius: CGFloat) {
        self.lineWidth = lineWidth
        self.rect = rect
        self.cornerRadius = cornerRadius
        offset = lineWidth / 2
    }

    // MARK: Functions

    open func point(
        edgeType: CornerEdgeType?,
        corner: UIRectCorner,
        xOffset: Bool = true,
        yOffset: Bool = true
    )
        -> Point {
        var a: CGFloat = 0
        var b: CGFloat = 0
        var aOp: CGFloat = 1
        var bOp: CGFloat = 1
        var rotated = false

        let correctedXOffset = xOffset ? offset : 0
        let correctedYOffset = yOffset ? offset : 0
        switch corner {
        case .topRight:
            a = rect.width - correctedXOffset
            b = rect.origin.y + correctedYOffset
            aOp = -1

        case .topLeft:
            a = rect.origin.y + correctedYOffset
            b = rect.origin.x + correctedXOffset
            rotated = true

        case .bottomRight:
            a = rect.height - correctedYOffset
            b = rect.width - correctedXOffset
            aOp = -1
            bOp = -1
            rotated = true

        case .bottomLeft:
            a = rect.origin.x + correctedXOffset
            b = rect.height - correctedYOffset
            bOp = -1

        default: ()
        }
        switch edgeType {
        case .start: a += aOp * cornerRadius * cornerCoefficient

        case .end: b += bOp * cornerRadius * cornerCoefficient

        case .center:
            a += aOp * cornerRadius * cornerCoefficient
            b += bOp * cornerRadius * cornerCoefficient

        case .none: ()
        }

        return Point(x: a, y: b, rotated: rotated)
    }

    open func corner(corner: UIRectCorner) -> UIBezierPath {
        let path = UIBezierPath()
        let startAngle: CGFloat
        let endAngle: CGFloat
        switch corner {
        case .topLeft:
            startAngle = .pi
            endAngle = -0.5 * .pi

        case .topRight:
            startAngle = 1.5 * .pi
            endAngle = 2 * .pi

        case .bottomRight:
            startAngle = 0
            endAngle = 0.5 * .pi

        case .bottomLeft:
            startAngle = 0.5 * .pi
            endAngle = .pi

        default:
            startAngle = 0
            endAngle = 0
        }
        path.move(to: point(edgeType: .start, corner: corner).cgPoint)
        path.addArc(
            withCenter: point(edgeType: .center, corner: corner).cgPoint,
            radius: cornerRadius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )

        return path
    }
}

extension CornerPath {
    public enum CornerEdgeType {
        case start
        case end
        case center
    }

    public struct Point {
        // MARK: Properties

        let x: CGFloat
        let y: CGFloat
        let rotated: Bool

        // MARK: Computed Properties

        var cgPoint: CGPoint {
            CGPoint(x: rotated ? y : x, y: rotated ? x : y)
        }

        // MARK: Lifecycle

        init(x: CGFloat, y: CGFloat, rotated: Bool = false) {
            self.x = x
            self.y = y
            self.rotated = rotated
        }

        // MARK: Functions

        func shifted(x: CGFloat = 0, y: CGFloat = 0) -> Point {
            Point(x: self.x + x, y: self.y + y, rotated: rotated)
        }
    }

    public struct ControlPoint {
        // MARK: Properties

        let point: CGPoint
        let cp1: CGPoint
        let cp2: CGPoint

        // MARK: Computed Properties

        var description: String {
            "P: [\(point.x): \(point.y)] CP1: [\(cp1.x): \(cp1.y)]  CP2: [\(cp2.x): \(cp2.y)]"
        }

        // MARK: Lifecycle

        init(_ point: CGPoint, _ cp1: CGPoint = .zero, _ cp2: CGPoint = .zero) {
            self.point = point
            self.cp1 = cp1
            self.cp2 = cp2
        }
    }
}
