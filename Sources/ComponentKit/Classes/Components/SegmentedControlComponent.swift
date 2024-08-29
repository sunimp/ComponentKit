//
//  SegmentedControlComponent.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/29.
//

import UIKit

import SnapKit
import ThemeKit

public class SegmentedControlComponent: UIView {
    
    public let segmentedControl = UISegmentedControl()
    
    public var onChange: ((Int) -> Void)?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
        
        segmentedControl.setContentCompressionResistancePriority(.required, for: .horizontal)
        segmentedControl.setContentHuggingPriority(.required, for: .horizontal)
        segmentedControl.setTitleTextAttributes([
            .foregroundColor: UIColor.zx001,
            .font: UIFont.subhead2
        ], for: .normal)
        segmentedControl.setTitleTextAttributes([
            .foregroundColor: UIColor.cg005,
            .font: UIFont.subhead1
        ], for: .selected)
        segmentedControl.addTarget(self, action: #selector(handleSegmentChanged), for: .valueChanged)
    }
    
    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func handleSegmentChanged(_ sender: UISegmentedControl) {
        onChange?(sender.selectedSegmentIndex)
    }
}
