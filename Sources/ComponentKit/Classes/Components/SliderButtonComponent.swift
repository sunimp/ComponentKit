//
//  SliderButtonComponent.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/20.
//

import UIKit

import ThemeKit
import SnapKit

public class SliderButtonComponent: UIView {
    
    public let button = SliderButton()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(button)
        button.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
