//  ComponentKit.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/20.
//

import UIKit

public class ComponentKit {

    public static var bundle: Bundle? {
        Bundle.module
    }

    public static func image(named: String) -> UIImage? {
        UIImage(named: named, in: Bundle.module, compatibleWith: nil)
    }

}
