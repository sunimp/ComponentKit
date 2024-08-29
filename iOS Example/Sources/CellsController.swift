//
//  CellsController.swift
//  ComponentKit-Example
//
//  Created by Sun on 2024/8/19.
//

import UIKit

import ThemeKit
import SnapKit
import SectionsTableView
import ComponentKit

class CellsController: ThemeViewController {
    private let tableView = SectionsTableView(style: .grouped)
    
    private let staticCell = ComponentCell()
    private var hiddenMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onChange))
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.sectionDataSource = self
        
        staticCell.set(backgroundStyle: .bordered)
        CellBuilder.buildStatic(cell: staticCell, rootElement: .hStack([
            .image20 { component in
                component.imageView.image = UIImage(systemName: "airplane")
                component.imageView.tintColor = .zx003
                component.imageView.contentMode = .scaleAspectFit
            },
            .text { component in
                component.font = .body
                component.textColor = .zx001
                component.text = "Static Airplane Cell"
            }
        ]))
        
        tableView.buildSections()
    }
    
    @objc private func onChange() {
        hiddenMode = !hiddenMode
        tableView.reload()
    }
    
}

extension CellsController: SectionsDataSource {
    
    private func rowSpinner() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .text { component in
                    component.font = .subhead2
                    component.textColor = .zx001
                    component.text = "Spinner"
                },
                .spinner20 { _ in }
            ]),
            tableView: tableView,
            id: "row-spinner",
            height: .heightCell48,
            autoDeselect: true,
            bind: { cell in
                cell.set(backgroundStyle: .bordered, isFirst: true)
            },
            action: {
                print("Did tap spinner row")
            }
        )
    }
    
    private func rowTextButton() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .text { component in
                    component.font = .subhead2
                    component.textColor = .zx001
                    component.text = "Text Button"
                },
                .textButton { component in
                    component.font = .subhead1
                    component.textColor = .cg002
                    component.text = "Press Me"
                    component.onTap = {
                        print("Did Tap")
                    }
                }
            ]),
            tableView: tableView,
            id: "row-text-button",
            height: .heightCell48,
            autoDeselect: true,
            bind: { cell in
                cell.set(backgroundStyle: .bordered)
            },
            action: {
                print("Did tap text row")
            }
        )
    }
    
    private func rowDeterminiteSpinner() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .text { component in
                    component.font = .subhead2
                    component.textColor = .zx001
                    component.text = "Determinite Spinner"
                },
                .determiniteSpinner20 { component in
                    component.set(progress: 0.75)
                }
            ]),
            tableView: tableView,
            id: "row-determinite-spinner",
            height: .heightCell48,
            bind: { cell in
                cell.set(backgroundStyle: .bordered)
            }
        )
    }
    
    private func rowWallet1New() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .vStackCentered([
                    .text { component in
                        component.font = .body
                        component.textColor = .zx001
                        component.text = "Wallet One"
                    },
                    .margin(3),
                    .text { component in
                        component.font = .subhead2
                        component.textColor = .zx003
                        component.text = "Subtitle"
                    },
                ]),
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                    component.imageView.tintColor = .cg002
                    component.imageView.contentMode = .scaleAspectFit
                },
                .margin4,
                .secondaryCircleButton { component in
                    component.button.set(image: UIImage(named: "icon_20"), style: .transparent)
                    component.onTap = { print("Did tap edit wallet") }
                }
            ]),
            layoutMargins: UIEdgeInsets(top: 0, left: CellBuilder.defaultMargin, bottom: 0, right: .margin4),
            tableView: tableView,
            id: "row-wallet-1",
            height: .heightCell64,
            bind: { cell in
                cell.set(backgroundStyle: .bordered)
            }
        )
    }
    
    private func rowMarketCap() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .text { component in
                    component.font = .subhead2
                    component.textColor = .zx002
                    component.text = "Market Cap"
                    component.setContentHuggingPriority(.required, for: .horizontal)
                },
                .margin8,
                .badge { component in
                    component.badgeView.set(style: .small)
                    component.badgeView.text = "12"
                },
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx001
                    component.text = "$74.7 B"
                    component.textAlignment = .right
                },
            ]),
            tableView: tableView,
            id: "row-market-cap",
            height: .heightCell48,
            bind: { cell in
                cell.set(backgroundStyle: .bordered)
            }
        )
    }
    
    private func rowContract() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "bitcoinsign.square.fill")
                    component.imageView.tintColor = .cg005
                    component.imageView.contentMode = .scaleAspectFit
                },
                .text { component in
                    component.font = .subhead2
                    component.textColor = .zx003
                    component.text = "0xai9823nfw2873dmn3498cm3498jf938hdfh98hwe8"
                    component.lineBreakMode = .byTruncatingMiddle
                },
                .secondaryCircleButton { component in
                    component.isHidden = self.hiddenMode
                    component.button.set(image: UIImage(systemName: "shippingbox")?.withRenderingMode(.alwaysTemplate))
                    component.onTap = { print("Did tap copy") }
                },
                .secondaryCircleButton { component in
                    component.button.set(image: UIImage(systemName: "globe")?.withRenderingMode(.alwaysTemplate))
                    component.onTap = { print("Did tap globe") }
                }
            ]),
            tableView: tableView,
            id: "row-contract",
            height: .heightCell48,
            bind: { cell in
                cell.set(backgroundStyle: .bordered)
            }
        )
    }
    
    private func rowMarket1() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "bitcoinsign.circle")
                    component.imageView.tintColor = .zx002
                    component.imageView.contentMode = .scaleAspectFit
                },
                .vStackCentered([
                    .text { component in
                        component.font = .body
                        component.textColor = .zx001
                        component.text = "Bitcoin"
                    },
                    .margin(3),
                    .hStack([
                        .badge { component in
                            component.badgeView.set(style: .small)
                            component.badgeView.text = "123"
                        },
                        .margin8,
                        .text { component in
                            component.font = .subhead2
                            component.textColor = .zx002
                            component.text = "BTC"
                        }
                    ])
                ]),
                .vStackCentered([
                    .text { component in
                        component.font = .body
                        component.textColor = .zx001
                        component.textAlignment = .right
                        component.text = "$65,145"
                    },
                    .margin(3),
                    .text { component in
                        component.font = .subhead2
                        component.textColor = .cg001
                        component.textAlignment = .right
                        component.text = "+2.35%"
                    }
                ]),
            ]),
            tableView: tableView,
            id: "row-market-1",
            height: .heightCell64,
            bind: { cell in
                cell.set(backgroundStyle: .bordered)
            }
        )
    }
    
    private func rowMarket2() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "bitcoinsign.circle")
                    component.imageView.tintColor = .zx002
                    component.imageView.contentMode = .scaleAspectFit
                },
                .vStackCentered([
                    .hStack([
                        .text { component in
                            component.font = .body
                            component.textColor = .zx001
                            component.text = "Ethereum"
                        },
                        .text { component in
                            component.font = .body
                            component.textColor = .zx001
                            component.textAlignment = .right
                            component.text = "$12,153"
                        }
                    ]),
                    .margin(3),
                    .hStack([
                        .badge { component in
                            component.badgeView.set(style: .small)
                            component.badgeView.text = "12"
                        },
                        .margin8,
                        .text { component in
                            component.font = .subhead2
                            component.textColor = .zx002
                            component.text = "ETH"
                        },
                        .text { component in
                            component.font = .subhead2
                            component.textColor = .cg001
                            component.textAlignment = .right
                            component.text = "-1.53%"
                        }
                    ]),
                ]),
            ]),
            tableView: tableView,
            id: "row-market-2",
            height: .heightCell64,
            bind: { cell in
                cell.set(backgroundStyle: .bordered)
            }
        )
    }
    
    private func rowStatic() -> RowProtocol {
        StaticRow(
            cell: staticCell,
            id: "row-text",
            height: .heightCell48
        )
    }
    
    private func rowMultiline() -> RowProtocol {
        let backgroundStyle: ComponentCell.BackgroundStyle = .bordered
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        let font: UIFont = .subhead2
        
        return CellBuilder.row(
            rootElement: .hStack([
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "square")
                    component.imageView.tintColor = .zx003
                    component.imageView.contentMode = .scaleAspectFit
                },
                .text { component in
                    component.font = font
                    component.textColor = .zx001
                    component.text = text
                    component.numberOfLines = 0
                }
            ]),
            tableView: tableView,
            id: "row-multiline",
            dynamicHeight: { containerWidth in
                CellBuilder.height(
                    containerWidth: containerWidth,
                    backgroundStyle: backgroundStyle,
                    text: text,
                    font: font,
                    elements: [.fixed(width: 20), .multiline]
                )
            },
            bind: { cell in
                cell.set(backgroundStyle: backgroundStyle)
            }
        )
    }
    
    private func rowMultiline2() -> RowProtocol {
        let backgroundStyle: ComponentCell.BackgroundStyle = .bordered
        let titleFont: UIFont = .subhead2
        let titleText = "Title"
        let textFont: UIFont = .subhead1I
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        
        return CellBuilder.row(
            rootElement: .hStack([
                .text { component in
                    component.font = titleFont
                    component.textColor = .zx003
                    component.text = titleText
                },
                .text { component in
                    component.font = textFont
                    component.textColor = .zx001
                    component.text = text
                    component.numberOfLines = 0
                }
            ]),
            tableView: tableView,
            id: "row-multiline-2",
            dynamicHeight: { containerWidth in
                CellBuilder.height(
                    containerWidth: containerWidth,
                    backgroundStyle: backgroundStyle,
                    text: text,
                    font: textFont,
                    elements: [.fixed(width: TextComponent.width(font: titleFont, text: titleText)), .multiline]
                )
            },
            bind: { cell in
                cell.set(backgroundStyle: backgroundStyle)
            }
        )
    }
    
    private func rowSettings1() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "book")
                    component.imageView.tintColor = .zx003
                    component.imageView.contentMode = .scaleAspectFit
                },
                .text { component in
                    component.font = .body
                    component.textColor = .zx001
                    component.text = "Academy"
                },
                .image16 { component in
                    component.imageView.image = UIImage(systemName: "chevron.forward")
                    component.imageView.tintColor = .zx003
                    component.imageView.contentMode = .scaleAspectFit
                }
            ]),
            tableView: tableView,
            id: "row-settings-1",
            height: .heightCell48,
            bind: { cell in
                cell.set(backgroundStyle: .bordered)
            }
        )
    }
    
    private func rowSettings2() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "shield")
                    component.imageView.tintColor = .zx003
                    component.imageView.contentMode = .scaleAspectFit
                },
                .text { component in
                    component.font = .body
                    component.textColor = .zx001
                    component.text = "Security Center"
                },
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                    component.imageView.tintColor = .cg002
                    component.imageView.contentMode = .scaleAspectFit
                },
                .margin12,
                .image16 { component in
                    component.imageView.image = UIImage(systemName: "chevron.forward")
                    component.imageView.tintColor = .zx003
                    component.imageView.contentMode = .scaleAspectFit
                }
            ]),
            tableView: tableView,
            id: "row-settings-2",
            height: .heightCell48,
            bind: { cell in
                cell.set(backgroundStyle: .bordered)
            }
        )
    }
    
    private func rowSettings3() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "globe")
                    component.imageView.tintColor = .zx003
                    component.imageView.contentMode = .scaleAspectFit
                },
                .text { component in
                    component.font = .body
                    component.textColor = .zx001
                    component.text = "Language"
                },
                .text { component in
                    component.font = .subhead1
                    component.textColor = .zx003
                    component.text = "English"
                    component.setContentCompressionResistancePriority(.required, for: .horizontal)
                    component.setContentHuggingPriority(.required, for: .horizontal)
                },
                .margin8,
                .image16 { component in
                    component.imageView.image = UIImage(systemName: "chevron.forward")
                    component.imageView.tintColor = .zx003
                    component.imageView.contentMode = .scaleAspectFit
                }
            ]),
            tableView: tableView,
            id: "row-settings-3",
            height: .heightCell48,
            bind: { cell in
                cell.set(backgroundStyle: .bordered)
            }
        )
    }
    
    private func rowSettings4() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "circle")
                    component.imageView.tintColor = .zx003
                    component.imageView.contentMode = .scaleAspectFit
                },
                .vStackCentered([
                    .text { component in
                        component.font = .body
                        component.textColor = .zx001
                        component.text = "Wallet 1"
                    },
                    .margin(3),
                    .text { component in
                        component.font = .subhead2
                        component.textColor = .zx003
                        component.text = "12 words"
                    }
                ]),
                .image16 { component in
                    component.imageView.image = UIImage(systemName: "pencil")
                    component.imageView.tintColor = .zx003
                    component.imageView.contentMode = .scaleAspectFit
                }
            ]),
            tableView: tableView,
            id: "row-settings-4",
            height: .heightCell64,
            bind: { cell in
                cell.set(backgroundStyle: .bordered)
            }
        )
    }
    
    private func rowSettings5() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "circle.inset.filled")
                    component.imageView.tintColor = .cg005
                    component.imageView.contentMode = .scaleAspectFit
                },
                .vStackCentered([
                    .text { component in
                        component.font = .body
                        component.textColor = .zx001
                        component.text = "Wallet 2"
                    },
                    .margin(3),
                    .text { component in
                        component.font = .subhead2
                        component.textColor = .zx003
                        component.text = "24 words"
                    }
                ]),
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                    component.imageView.tintColor = .cg002
                    component.imageView.contentMode = .scaleAspectFit
                },
                .image16 { component in
                    component.imageView.image = UIImage(systemName: "pencil")
                    component.imageView.tintColor = .zx003
                    component.imageView.contentMode = .scaleAspectFit
                }
            ]),
            tableView: tableView,
            id: "row-settings-5",
            height: .heightCell64,
            bind: { cell in
                cell.set(backgroundStyle: .bordered)
            }
        )
    }
    
    private func rowSettings6() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "suit.spade")
                    component.imageView.tintColor = .zx003
                    component.imageView.contentMode = .scaleAspectFit
                },
                .text { component in
                    component.font = .body
                    component.textColor = .zx001
                    component.text = "Passcode "
                },
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                    component.imageView.tintColor = .cg002
                    component.imageView.contentMode = .scaleAspectFit
                },
                .switch { component in
                    component.switchView.isOn = true
                    component.onSwitch = {
                        print("Did toggle switch: \($0)")
                    }
                }
            ]),
            tableView: tableView,
            id: "row-settings-6",
            height: .heightCell48,
            bind: { cell in
                cell.set(backgroundStyle: .bordered)
            }
        )
    }
    
    private func rowSettings7() -> RowProtocol {
        CellBuilder.row(
            rootElement: .hStack([
                .image20 { component in
                    component.imageView.image = UIImage(systemName: "tornado")
                    component.imageView.tintColor = .zx003
                    component.imageView.contentMode = .scaleAspectFit
                },
                .text { component in
                    component.font = .body
                    component.textColor = .zx001
                    component.text = "Frequency"
                },
                .segmentedControl { component in
                    component.segmentedControl.insertSegment(withTitle: "Hourly", at: 0, animated: false)
                    component.segmentedControl.insertSegment(withTitle: "Daily", at: 1, animated: false)
                    component.segmentedControl.insertSegment(withTitle: "Weekly", at: 2, animated: false)
                    component.segmentedControl.selectedSegmentIndex = 0
                    component.onChange = {
                        print("Did change select: \($0)")
                    }
                }
            ]),
            tableView: tableView,
            id: "row-settings-7",
            height: .heightCell48,
            bind: { cell in
                cell.set(backgroundStyle: .bordered, isLast: true)
            }
        )
    }
    
    func buildSections() -> [SectionProtocol] {
        [
            Section(
                id: "main",
                headerState: .margin(height: .margin12),
                footerState: .margin(height: .margin32),
                rows: [
                    rowSpinner(),
                    rowTextButton(),
                    rowDeterminiteSpinner(),
                    rowWallet1New(),
                    rowMarketCap(),
                    rowContract(),
                    rowMarket1(),
                    rowMarket2(),
                    rowStatic(),
                    rowMultiline(),
                    rowMultiline2(),
                    rowSettings1(),
                    rowSettings2(),
                    rowSettings3(),
                    rowSettings4(),
                    rowSettings5(),
                    rowSettings6(),
                    rowSettings7(),
                ]
            )
        ]
    }
    
}
