//
//  ComponentKit.swift
//
//  Created by Sun on 2021/12/1.
//

import UIKit

public class ComponentKit {
    // MARK: Static Computed Properties

    public static var bundle: Bundle? {
        Bundle.module
    }

    // MARK: Static Functions

    public static func image(named: String) -> UIImage? {
        UIImage(named: named, in: Bundle.module, compatibleWith: nil)
    }
}
