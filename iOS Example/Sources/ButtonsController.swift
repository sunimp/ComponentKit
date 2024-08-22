//
//  ButtonsController.swift
//  ComponentKit-Example
//
//  Created by Sun on 2024/8/19.
//

import UIKit

import ThemeKit
import SnapKit
import ComponentKit
import SectionsTableView

class ButtonsController: ThemeViewController {
    
    private let tableView = SectionsTableView(style: .grouped)
    
    private let primaryBlueCell = ComponentCell()
    private let primaryBlueIconCell = ComponentCell()
    private let primaryBlueSpinnerCell = ComponentCell()
    private let primaryBlueIconCell2 = ComponentCell()
    private let primaryBlueSpinnerCell2 = ComponentCell()
    private let sliderCell = ComponentCell()
    private let sliderDisabledCell = ComponentCell()
    private let primaryRedCell = ComponentCell()
    private let primaryRedIconCell = ComponentCell()
    private let primaryGrayCell = ComponentCell()
    private let primaryGrayIconCell = ComponentCell()
    private let primaryTransparentIconCell = ComponentCell()
    private let primaryTransparentCell = ComponentCell()
    private let primaryCircleCell = ComponentCell()
    private let secondaryCell = ComponentCell()
    private let secondaryFullCell = ComponentCell()
    private let secondaryFull2Cell = ComponentCell()
    private let secondaryTransparentCell = ComponentCell()
    private let secondaryTransparent2Cell = ComponentCell()
    private let secondaryCircleCell = ComponentCell()
    private let transparentIconCell = ComponentCell()
    
    private var sliderButton: SliderButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.sectionDataSource = self
        
        configureCells()
        tableView.buildSections()
    }
    
    private func configureCells() {
        primaryBlueCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(
            cell: primaryBlueCell,
            rootElement: .hStack(
                [
                    .text { component in
                        component.font = .subhead1
                        component.textColor = .zx001
                        component.text = "Primary"
                    },
                    .primaryButton { [weak self] component in
                        component.button.set(style: .blue)
                        component.button.setTitle("Blue", for: .normal)
                        component.button.setContentHuggingPriority(.required, for: .horizontal)
                        component.onTap = { self?.sliderButton?.reset() }
                    },
                    .margin8,
                    .primaryButton { component in
                        component.button.set(style: .blue)
                        component.button.isEnabled = false
                        component.button.setTitle("Disabled", for: .normal)
                        component.button.setContentHuggingPriority(.required, for: .horizontal)
                    }
                ]
            )
        )
        
        primaryBlueIconCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: primaryBlueIconCell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Primary Icon"
                },
                .primaryButton { component in
                    component.button.set(style: .blue, accessoryType: .icon(image: UIImage(named: "arrow_swap_2_24")))
                    component.button.setTitle("Blue", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                    component.button.setContentCompressionResistancePriority(.required, for: .horizontal)
                },
                .margin8,
                .primaryButton { component in
                    component.button.set(style: .blue, accessoryType: .icon(image: UIImage(named: "arrow_swap_2_24")))
                    component.button.isEnabled = false
                    component.button.setTitle("Disabled", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                    component.button.setContentCompressionResistancePriority(.required, for: .horizontal)
                }
            ]
        ))
        
        primaryBlueSpinnerCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: primaryBlueSpinnerCell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Primary Spinner"
                },
                .primaryButton { component in
                    component.button.set(style: .blue, accessoryType: .spinner)
                    component.button.setTitle("Blue", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                    component.button.setContentCompressionResistancePriority(.required, for: .horizontal)
                },
                .margin8,
                .primaryButton { component in
                    component.button.set(style: .blue, accessoryType: .spinner)
                    component.button.isEnabled = false
                    component.button.setTitle("Disabled", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                    component.button.setContentCompressionResistancePriority(.required, for: .horizontal)
                }
            ]
        ))
        
        primaryBlueIconCell2.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: primaryBlueIconCell2, rootElement: .hStack(
            [
                .primaryButton { component in
                    component.button.set(style: .blue, accessoryType: .icon(image: UIImage(named: "arrow_swap_2_24")))
                    component.button.setTitle("Blue", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                    component.button.setContentCompressionResistancePriority(.required, for: .horizontal)
                }
            ]
        ))
        
        primaryBlueSpinnerCell2.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: primaryBlueSpinnerCell2, rootElement: .hStack(
            [
                .primaryButton { component in
                    component.button.set(style: .blue, accessoryType: .spinner)
                    component.button.setTitle("Blue", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                    component.button.setContentCompressionResistancePriority(.required, for: .horizontal)
                }
            ]
        ))
        
        sliderCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: sliderCell, rootElement: .hStack([
            .sliderButton { [weak self] component in
                component.button.title = "Slide to Send"
                component.button.finalTitle = "Sending"
                component.button.slideImage = UIImage(named: "forward_24")
                component.button.finalImage = UIImage(named: "check_24")
                component.button.onTap = { print("On Tap Slider") }
                self?.sliderButton = component.button
            }
        ]))
        
        sliderDisabledCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: sliderDisabledCell, rootElement: .sliderButton { component in
            component.button.isEnabled = false
            component.button.title = "Slide to Send"
            component.button.slideImage = UIImage(named: "forward_24")
        })
        
        primaryRedCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: primaryRedCell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Primary"
                },
                .primaryButton { component in
                    component.button.set(style: .red)
                    component.button.setTitle("Red", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                },
                .margin8,
                .primaryButton { component in
                    component.button.set(style: .red)
                    component.button.isEnabled = false
                    component.button.setTitle("Disabled", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                }
            ]
        ))
        
        primaryRedIconCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: primaryRedIconCell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Primary"
                },
                .primaryButton { component in
                    component.button.set(style: .red, accessoryType: .icon(image: UIImage(named: "arrow_swap_2_24")))
                    component.button.setTitle("Red", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                    component.button.setContentCompressionResistancePriority(.required, for: .horizontal)
                },
                .margin8,
                .primaryButton { component in
                    component.button.set(style: .red, accessoryType: .icon(image: UIImage(named: "arrow_swap_2_24")))
                    component.button.isEnabled = false
                    component.button.setTitle("Disabled", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                    component.button.setContentCompressionResistancePriority(.required, for: .horizontal)
                }
            ]
        ))
        
        primaryGrayCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: primaryGrayCell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Primary"
                },
                .primaryButton { component in
                    component.button.set(style: .gray)
                    component.button.setTitle("Gray", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                },
                .margin8,
                .primaryButton { component in
                    component.button.set(style: .gray)
                    component.button.isEnabled = false
                    component.button.setTitle("Disabled", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                }
            ]
        ))
        
        primaryGrayIconCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: primaryGrayIconCell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Primary"
                },
                .primaryButton { component in
                    component.button.set(style: .gray, accessoryType: .icon(image: UIImage(named: "arrow_swap_2_24")))
                    component.button.setTitle("Gray", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                    component.button.setContentCompressionResistancePriority(.required, for: .horizontal)
                },
                .margin8,
                .primaryButton { component in
                    component.button.set(style: .gray, accessoryType: .icon(image: UIImage(named: "arrow_swap_2_24")))
                    component.button.isEnabled = false
                    component.button.setTitle("Disabled", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                    component.button.setContentCompressionResistancePriority(.required, for: .horizontal)
                }
            ]
        ))
        
        primaryTransparentCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: primaryTransparentCell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Primary"
                },
                .primaryButton { component in
                    component.button.set(style: .transparent)
                    component.button.setTitle("Transparent", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                },
                .margin8,
                .primaryButton { component in
                    component.button.set(style: .transparent)
                    component.button.isEnabled = false
                    component.button.setTitle("Disabled", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                }
            ]
        ))
        
        primaryTransparentIconCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: primaryTransparentIconCell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Primary"
                },
                .primaryButton { component in
                    component.button.set(style: .transparent, accessoryType: .icon(image: UIImage(named: "arrow_swap_2_24")))
                    component.button.setTitle("Transparent", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                    component.button.setContentCompressionResistancePriority(.required, for: .horizontal)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                },
                .margin8,
                .primaryButton { component in
                    component.button.set(style: .transparent, accessoryType: .icon(image: UIImage(named: "arrow_swap_2_24")))
                    component.button.isEnabled = false
                    component.button.setTitle("Disabled", for: .normal)
                    component.button.setContentHuggingPriority(.required, for: .horizontal)
                    component.button.setContentCompressionResistancePriority(.required, for: .horizontal)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                }
            ]
        ))
        
        primaryCircleCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: primaryCircleCell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Primary Circle"
                },
                .primaryCircleButton { component in
                    component.button.set(style: .blue)
                    component.button.set(image: UIImage(named: "arrow_swap_2_24"))
                },
                .margin4,
                .primaryCircleButton { component in
                    component.button.set(style: .red)
                    component.button.set(image: UIImage(named: "arrow_swap_2_24"))
                },
                .margin4,
                .primaryCircleButton { component in
                    component.button.set(style: .gray)
                    component.button.set(image: UIImage(named: "arrow_swap_2_24"))
                },
                .margin4,
                .primaryCircleButton { component in
                    component.button.set(style: .blue)
                    component.button.isEnabled = false
                    component.button.set(image: UIImage(named: "arrow_swap_2_24"))
                }
            ]
        ))
        
        secondaryCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: secondaryCell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Secondary"
                },
                .secondaryButton { component in
                    component.button.isSelected = true
                    component.button.set(style: .default)
                    component.button.setTitle("Selected", for: .normal)
                },
                .margin4,
                .secondaryButton { component in
                    component.button.set(style: .default)
                    component.button.setTitle("Default", for: .normal)
                },
                .margin4,
                .secondaryButton { component in
                    component.button.isEnabled = false
                    component.button.set(style: .default)
                    component.button.setTitle("Disabled", for: .normal)
                }
            ]
        ))
        
        secondaryTransparentCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: secondaryTransparentCell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Transparent"
                },
                .secondaryButton { component in
                    component.button.isSelected = true
                    component.button.set(style: .transparent)
                    component.button.setTitle("Copy", for: .normal)
                },
                .margin4,
                .secondaryButton { component in
                    component.button.set(style: .transparent)
                    component.button.setTitle("Copy", for: .normal)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                },
                .margin4,
                .secondaryButton { component in
                    component.button.isEnabled = false
                    component.button.set(style: .transparent)
                    component.button.setTitle("Copy", for: .normal)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                }
            ]
        ))
        
        secondaryTransparent2Cell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: secondaryTransparent2Cell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Transparent 2"
                },
                .secondaryButton { component in
                    component.button.isSelected = true
                    component.button.set(style: .transparent2)
                    component.button.setTitle("Copy", for: .normal)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                },
                .margin4,
                .secondaryButton { component in
                    component.button.set(style: .transparent2)
                    component.button.setTitle("Copy", for: .normal)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                },
                .margin4,
                .secondaryButton { component in
                    component.button.isEnabled = false
                    component.button.set(style: .transparent2)
                    component.button.setTitle("Copy", for: .normal)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                }
            ]
        ))
        
        secondaryFullCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: secondaryFullCell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Full"
                },
                .secondaryButton { component in
                    component.button.isSelected = true
                    component.button.set(style: .default, image: UIImage(named: "icon_20"))
                    component.button.setTitle("Copy", for: .normal)
                },
                .margin4,
                .secondaryButton { component in
                    component.button.set(style: .default, image: UIImage(named: "icon_20"))
                    component.button.setTitle("Copy", for: .normal)
                },
                .margin4,
                .secondaryButton { component in
                    component.button.isEnabled = false
                    component.button.set(style: .default, image: UIImage(named: "icon_20"))
                    component.button.setTitle("Copy", for: .normal)
                }
            ]
        ))
        
        secondaryFull2Cell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: secondaryFull2Cell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Full 2"
                },
                .secondaryButton { component in
                    component.button.isSelected = true
                    component.button.set(style: .transparent2, image: UIImage(named: "icon_20"))
                    component.button.setTitle("Copy", for: .normal)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                },
                .margin4,
                .secondaryButton { component in
                    component.button.set(style: .transparent2, image: UIImage(named: "icon_20"))
                    component.button.setTitle("Copy", for: .normal)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                },
                .margin4,
                .secondaryButton { component in
                    component.button.isEnabled = false
                    component.button.set(style: .transparent2, image: UIImage(named: "icon_20"))
                    component.button.setTitle("Copy", for: .normal)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                }
            ]
        ))
        
        secondaryCircleCell.set(backgroundStyle: .transparent)
        CellBuilder.buildStatic(cell: secondaryCircleCell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Secondary Circle"
                },
                .secondaryCircleButton { component in
                    component.button.isSelected = true
                    component.button.set(image: UIImage(named: "icon_20"))
                },
                .margin4,
                .secondaryCircleButton { component in
                    component.button.set(image: UIImage(named: "icon_20"))
                },
                .margin4,
                .secondaryCircleButton { component in
                    component.button.set(image: UIImage(named: "icon_20"), style: .red)
                },
                .margin4,
                .secondaryCircleButton { component in
                    component.button.isEnabled = false
                    component.button.set(image: UIImage(named: "icon_20"))
                }
            ]
        ))
        
        transparentIconCell.set(backgroundStyle: .transparent, isLast: true)
        CellBuilder.buildStatic(cell: transparentIconCell, rootElement: .hStack(
            [
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "Sec Circle Trans"
                },
                .secondaryCircleButton { component in
                    component.button.isSelected = true
                    component.button.set(image: UIImage(named: "icon_20"), style: .transparent)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                },
                .margin4,
                .secondaryCircleButton { component in
                    component.button.set(image: UIImage(named: "icon_20"), style: .transparent)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                },
                .margin4,
                .secondaryCircleButton { component in
                    component.button.isEnabled = false
                    component.button.set(image: UIImage(named: "icon_20"), style: .transparent)
                    component.button.borderWidth = 1
                    component.button.borderColor = .zx005.alpha(0.5)
                }
            ]
        ))
    }
    
}

extension ButtonsController: SectionsDataSource {
    
    func buildSections() -> [SectionProtocol] {
        [
            Section(
                id: "main",
                headerState: .margin(height: .margin12),
                footerState: .margin(height: .margin32),
                rows: [
                    StaticRow(cell: primaryBlueCell, id: "primary-blue", height: .heightCell64),
                    StaticRow(cell: primaryBlueIconCell, id: "primary-blue-icon", height: .heightCell64),
                    StaticRow(cell: primaryBlueSpinnerCell, id: "primary-blue-spinner", height: .heightCell64),
                    StaticRow(cell: primaryBlueIconCell2, id: "primary-blue-icon-2", height: .heightCell64),
                    StaticRow(cell: primaryBlueSpinnerCell2, id: "primary-blue-spinner-2", height: .heightCell64),
                    StaticRow(cell: sliderCell, id: "slider", height: 80),
                    StaticRow(cell: sliderDisabledCell, id: "slider-disabled", height: 80),
                    StaticRow(cell: primaryRedCell, id: "primary-red", height: .heightCell64),
                    StaticRow(cell: primaryRedIconCell, id: "primary-red-icon", height: .heightCell64),
                    StaticRow(cell: primaryGrayCell, id: "primary-gray", height: .heightCell64),
                    StaticRow(cell: primaryGrayIconCell, id: "primary-gray-icon", height: .heightCell64),
                    StaticRow(cell: primaryTransparentCell, id: "primary-transparent", height: .heightCell64),
                    StaticRow(cell: primaryTransparentIconCell, id: "primary-transparent-icon", height: .heightCell64),
                    StaticRow(cell: primaryCircleCell, id: "primary-icon", height: .heightCell64),
                    StaticRow(cell: secondaryCell, id: "secondary", height: .heightCell44),
                    StaticRow(cell: secondaryTransparentCell, id: "secondary-transparent", height: .heightCell44),
                    StaticRow(cell: secondaryTransparent2Cell, id: "secondary-transparent-2", height: .heightCell44),
                    StaticRow(cell: secondaryFullCell, id: "secondary-full", height: .heightCell44),
                    StaticRow(cell: secondaryFull2Cell, id: "secondary-full-2", height: .heightCell44),
                    StaticRow(cell: secondaryCircleCell, id: "secondary-circle", height: .heightCell44),
                    StaticRow(cell: transparentIconCell, id: "transparent-icon", height: .heightCell44),
                ]
            )
        ]
    }
    
}
