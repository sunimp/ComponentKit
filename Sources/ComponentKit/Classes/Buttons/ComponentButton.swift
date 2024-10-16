//
//  ComponentButton.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/25.
//

import UIKit

import ThemeKit

open class ComponentButton: UIButton {
    // MARK: Nested Types

    public enum ImagePosition {
        case top
        case left
        case bottom
        case right
    }

    // MARK: Overridden Properties

    override open var intrinsicContentSize: CGSize {
        let size = CGSize(
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude
        )
        return sizeThatFits(size)
    }

    // MARK: Computed Properties

    open var imagePosition: ImagePosition = .left {
        didSet {
            setNeedsLayout()
        }
    }
    
    open var imageSpacing: CGFloat = .margin8 {
        didSet {
            setNeedsLayout()
        }
    }
    
    open var contentInsets: UIEdgeInsets {
        get {
            contentEdgeInsets
        }
        set {
            contentEdgeInsets = newValue
        }
    }

    private var _imageView: UIImageView? {
        let _imageView_ = perform(NSSelectorFromString("_imageView")).takeUnretainedValue()
        if let imageView = _imageView_ as? UIImageView {
            return imageView
        }
        return nil
    }

    // MARK: Lifecycle

    public init(imagePosition: ImagePosition = .left, spacing: CGFloat = .margin8) {
        self.imagePosition = imagePosition
        imageSpacing = spacing
        
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overridden Functions

    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = size
        if bounds.size == size {
            newSize = CGSize(width: .max, height: .max)
        }
        
        let isImageViewShowing = currentImage != nil
        let isTitleLabelShowing = currentTitle != nil || currentAttributedTitle != nil
        
        var imageTotalSize: CGSize = .zero
        var titleTotalSize: CGSize = .zero
        let imageSpacing: CGFloat = isImageViewShowing && isTitleLabelShowing ? imageSpacing : 0
        
        let contentInsets = contentInsets
        var resultSize: CGSize = .zero
        let contentLimitSize = CGSize(
            width: newSize.width - contentInsets.horizontal,
            height: newSize.height - contentInsets.vertical
        )
        
        switch imagePosition {
        case .top,
             .bottom:
            if isImageViewShowing {
                let imageLimitWidth = contentLimitSize.width - imageEdgeInsets.horizontal
                var imageSize: CGSize = .zero
                if let imageView, imageView.image != nil {
                    imageSize = imageView
                        .sizeThatFits(CGSize(
                            width: imageLimitWidth,
                            height: .greatestFiniteMagnitude
                        ))
                } else {
                    if let currentImage {
                        imageSize = currentImage.size
                    }
                }
                
                imageSize.width = .minimum(imageSize.width, imageLimitWidth)
                imageTotalSize = CGSize(
                    width: imageSize.width + imageEdgeInsets.horizontal,
                    height: imageSize.height + imageEdgeInsets.vertical
                )
                
                if isTitleLabelShowing {
                    let titleLimitSize = CGSize(
                        width: contentLimitSize.width - titleEdgeInsets.horizontal,
                        height: contentLimitSize.height - imageTotalSize
                            .height - imageSpacing - titleEdgeInsets.vertical
                    )
                    
                    var titleSize: CGSize = .zero
                    if let titleLabel {
                        titleSize = titleLabel.sizeThatFits(titleLimitSize)
                    }
                    titleSize.height = .minimum(titleSize.height, titleLimitSize.height)
                    titleTotalSize = CGSize(
                        width: titleSize.width + titleEdgeInsets.horizontal,
                        height: titleSize.height + titleEdgeInsets.vertical
                    )
                }
                
                resultSize.width = contentInsets.horizontal
                resultSize.width += .maximum(imageTotalSize.width, titleTotalSize.width)
                resultSize.height = contentInsets.vertical + imageTotalSize
                    .height + imageSpacing + titleTotalSize.height
            }
            
        case .left,
             .right:
            if isImageViewShowing {
                let imageLimitHeight = contentLimitSize.height - imageEdgeInsets.vertical
                var imageSize: CGSize = .zero
                if let imageView, imageView.image != nil {
                    imageSize = imageView
                        .sizeThatFits(CGSize(
                            width: .greatestFiniteMagnitude,
                            height: imageLimitHeight
                        ))
                } else {
                    if let currentImage {
                        imageSize = currentImage.size
                    }
                }
                imageSize.height = .minimum(imageSize.height, imageLimitHeight)
                imageTotalSize = CGSize(
                    width: imageSize.width + imageEdgeInsets.horizontal,
                    height: imageSize.height + imageEdgeInsets.vertical
                )
            }
            
            if isTitleLabelShowing {
                let titleLimitSize = CGSize(
                    width: contentLimitSize.width - titleEdgeInsets.horizontal - imageTotalSize
                        .width - imageSpacing,
                    height: contentLimitSize.height - titleEdgeInsets.vertical
                )
                var titleSize: CGSize = .zero
                if let label = titleLabel {
                    titleSize = label.sizeThatFits(titleLimitSize)
                }
                titleSize.height = .minimum(titleSize.height, titleLimitSize.height)
                titleTotalSize = CGSize(
                    width: titleSize.width + titleEdgeInsets.horizontal,
                    height: titleSize.height + titleEdgeInsets.vertical
                )
            }
            
            resultSize.width = contentInsets.horizontal + imageTotalSize
                .width + imageSpacing + titleTotalSize.width
            resultSize.height = contentInsets.vertical
            resultSize.height += .maximum(imageTotalSize.height, titleTotalSize.height)
        }
        
        return resultSize
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        guard !bounds.isEmpty else {
            return
        }
        
        let isImageViewShowing = currentImage != nil
        let isTitleLabelShowing = currentTitle != nil || currentAttributedTitle != nil
        
        var imageLimitSize: CGSize = .zero
        var titleLimitSize: CGSize = .zero
        var imageTotalSize: CGSize = .zero
        var titleTotalSize: CGSize = .zero
        
        let imageSpacing: CGFloat = (isImageViewShowing && isTitleLabelShowing)
            ? imageSpacing
            : 0
        
        var imageFrame: CGRect = .zero
        var titleFrame: CGRect = .zero
        let contentInsets = contentInsets
        let contentSize = CGSize(
            width: bounds.width - contentInsets.horizontal,
            height: bounds.height - contentInsets.vertical
        )
        
        if isImageViewShowing {
            imageLimitSize = CGSize(
                width: contentSize.width - imageEdgeInsets.horizontal,
                height: contentSize.height - imageEdgeInsets.vertical
            )
            var imageSize: CGSize = .zero
            if let imageView = _imageView, imageView.image != nil {
                imageSize = imageView.sizeThatFits(imageLimitSize)
            } else {
                if let currentImage {
                    imageSize = currentImage.size
                }
            }
            imageSize.width = .minimum(imageLimitSize.width, imageSize.width)
            imageSize.height = .minimum(imageLimitSize.height, imageSize.height)
            imageFrame = CGRect(origin: .zero, size: imageSize)
            imageTotalSize = CGSize(
                width: imageSize.width + imageEdgeInsets.horizontal,
                height: imageSize.height + imageEdgeInsets.vertical
            )
        }
        
        let ensureBoundsPositive: (UIView) -> Void = { view in
            var viewBounds = view.bounds
            if viewBounds.minX < 0 || viewBounds.minY < 0 {
                viewBounds = CGRect(origin: .zero, size: viewBounds.size)
                view.bounds = viewBounds
            }
        }
        
        if isImageViewShowing {
            if let imageView = _imageView {
                ensureBoundsPositive(imageView)
            }
        }
        
        if isTitleLabelShowing {
            if let label = titleLabel {
                ensureBoundsPositive(label)
            }
        }
        
        if imagePosition == .top || imagePosition == .bottom {
            if isTitleLabelShowing {
                titleLimitSize = CGSize(
                    width: contentSize.width - titleEdgeInsets.horizontal,
                    height: contentSize.height - imageTotalSize
                        .height - imageSpacing - titleEdgeInsets.vertical
                )
                var titleSize: CGSize = .zero
                if let label = titleLabel {
                    titleSize = label.sizeThatFits(titleLimitSize)
                }
                titleSize.width = .minimum(titleLimitSize.width, titleSize.width)
                titleSize.height = .minimum(titleLimitSize.height, titleSize.height)
                titleFrame = CGRect(origin: .zero, size: titleSize)
                titleTotalSize = CGSize(
                    width: titleSize.width + titleEdgeInsets.horizontal,
                    height: titleSize.height + titleEdgeInsets.vertical
                )
            }
            
            switch contentHorizontalAlignment {
            case .left:
                if isImageViewShowing {
                    imageFrame.origin.x = contentInsets.left + imageEdgeInsets.left
                }
                if isTitleLabelShowing {
                    titleFrame.origin.x = contentInsets.left + titleEdgeInsets.left
                }
                
            case .center:
                if isImageViewShowing {
                    imageFrame.origin.x = contentInsets.left + imageEdgeInsets
                        .left + (imageLimitSize.width - imageFrame.width) / 2.0
                }
                if isTitleLabelShowing {
                    titleFrame.origin.x = contentInsets.left + titleEdgeInsets
                        .left + (titleLimitSize.width - titleFrame.width) / 2.0
                }
                
            case .right:
                if isImageViewShowing {
                    imageFrame.origin.x = bounds.width - contentInsets.right - imageEdgeInsets
                        .right - imageFrame.width
                }
                if isTitleLabelShowing {
                    titleFrame.origin.x = bounds.width - contentInsets.right - titleEdgeInsets
                        .right - titleFrame.width
                }
                
            case .fill:
                if isImageViewShowing {
                    imageFrame.origin.x = contentInsets.left + imageEdgeInsets.left
                    imageFrame.size.width = imageLimitSize.width
                }
                
                if isTitleLabelShowing {
                    titleFrame.origin.x = contentInsets.left + titleEdgeInsets.left
                    titleFrame.size.width = titleLimitSize.width
                }
                
            default:
                break
            }
            
            if case .top = imagePosition {
                switch contentVerticalAlignment {
                case .top:
                    if isImageViewShowing {
                        imageFrame.origin.y = contentInsets.top + imageEdgeInsets.top
                    }
                    if isTitleLabelShowing {
                        titleFrame.origin.y = contentInsets.top + imageTotalSize
                            .height + imageSpacing + titleEdgeInsets.top
                    }
                    
                case .center:
                    let contentHeight = imageTotalSize
                        .height + imageSpacing + titleTotalSize.height
                    let minY = (contentSize.height - contentHeight) / 2.0 + contentInsets.top
                    if isImageViewShowing {
                        imageFrame.origin.y = minY + imageEdgeInsets.top
                    }
                    if isTitleLabelShowing {
                        titleFrame.origin.y = minY + imageTotalSize
                            .height + imageSpacing + titleEdgeInsets.top
                    }
                    
                case .bottom:
                    if isTitleLabelShowing {
                        titleFrame.origin.y = bounds.height - contentInsets.bottom - titleEdgeInsets
                            .bottom - titleFrame.height
                    }
                    if isImageViewShowing {
                        imageFrame.origin.y = bounds.height - contentInsets.bottom - titleTotalSize
                            .height - imageSpacing - imageEdgeInsets
                            .bottom - imageFrame
                            .height
                    }
                    
                case .fill:
                    if isImageViewShowing, isTitleLabelShowing {
                        imageFrame.origin.y = contentInsets.top + imageEdgeInsets.top
                        titleFrame.origin.y = contentInsets.top + imageTotalSize
                            .height + imageSpacing + titleEdgeInsets.top
                        titleFrame.size.height = bounds.height - contentInsets.bottom - titleEdgeInsets
                            .bottom - titleFrame.minY
                    } else if isImageViewShowing {
                        imageFrame.origin.y = contentInsets.top + imageEdgeInsets.top
                        imageFrame.size.height = contentSize.height - imageEdgeInsets.vertical
                    } else {
                        titleFrame.origin.y = contentInsets.top + titleEdgeInsets.top
                        titleFrame.size.height = contentSize.height - titleEdgeInsets.vertical
                    }
                    
                default:
                    break
                }
            } else {
                switch contentVerticalAlignment {
                case .top:
                    if isTitleLabelShowing {
                        titleFrame.origin.y = contentInsets.top + titleEdgeInsets.top
                    }
                    if isImageViewShowing {
                        imageFrame.origin.y = contentInsets.top + titleTotalSize
                            .height + imageSpacing + imageEdgeInsets.top
                    }
                    
                case .center:
                    let contentHeight = imageTotalSize.height + titleTotalSize
                        .height + imageSpacing
                    let minY = (contentSize.height - contentHeight) / 2.0 + contentInsets.top
                    if isTitleLabelShowing {
                        titleFrame.origin.y = minY + titleEdgeInsets.top
                    }
                    if isImageViewShowing {
                        imageFrame.origin.y = minY + titleTotalSize
                            .height + imageSpacing + imageEdgeInsets.top
                    }
                    
                case .bottom:
                    if isImageViewShowing {
                        imageFrame.origin.y = bounds.height - contentInsets.bottom - imageEdgeInsets
                            .bottom - imageFrame.height
                    }
                    if isTitleLabelShowing {
                        titleFrame.origin.y = bounds.height - contentInsets.bottom - imageTotalSize
                            .height - imageSpacing - titleEdgeInsets
                            .bottom - titleFrame
                            .height
                    }
                    
                case .fill:
                    
                    if isImageViewShowing, isTitleLabelShowing {
                        imageFrame.origin.y = bounds.height - contentInsets.bottom - imageEdgeInsets.bottom - imageFrame
                            .height
                        titleFrame.origin.y = contentInsets.top + titleEdgeInsets.top
                        titleFrame.size.height = bounds.height - contentInsets.bottom - imageTotalSize
                            .height - imageSpacing - titleEdgeInsets.bottom - titleFrame.minY
                    } else if isImageViewShowing {
                        imageFrame.origin.y = contentInsets.top + imageEdgeInsets.top
                        imageFrame.size.height = contentSize.height - imageEdgeInsets.vertical
                    } else {
                        titleFrame.origin.y = contentInsets.top + titleEdgeInsets.top
                        titleFrame.size.height = contentSize.height - titleEdgeInsets.vertical
                    }

                default:
                    break
                }
            }
            
            if isImageViewShowing {
                _imageView?.frame = imageFrame
            }
            
            if isTitleLabelShowing {
                titleLabel?.frame = titleFrame
            }
            
        } else if imagePosition == .left || imagePosition == .right {
            if isTitleLabelShowing {
                titleLimitSize = CGSize(
                    width: contentSize.width - titleEdgeInsets.horizontal - imageTotalSize
                        .width - imageSpacing,
                    height: contentSize.height - titleEdgeInsets.vertical
                )
                var titleSize: CGSize = .zero
                if let label = titleLabel {
                    titleSize = label.sizeThatFits(titleLimitSize)
                }
                titleSize.width = .minimum(titleLimitSize.width, titleSize.width)
                titleSize.height = .minimum(titleLimitSize.height, titleSize.height)
                titleFrame = CGRect(origin: .zero, size: titleSize)
                titleTotalSize = CGSize(
                    width: titleSize.width + titleEdgeInsets.horizontal,
                    height: titleSize.height + titleEdgeInsets.vertical
                )
            }
            
            switch contentVerticalAlignment {
            case .top:
                if isImageViewShowing {
                    imageFrame.origin.y = contentInsets.top + imageEdgeInsets.top
                }
                if isTitleLabelShowing {
                    titleFrame.origin.y = contentInsets.top + titleEdgeInsets.top
                }
                
            case .center:
                if isImageViewShowing {
                    imageFrame.origin.y = contentInsets
                        .top + (contentSize.height - imageFrame.height) / 2.0 + imageEdgeInsets.top
                }
                if isTitleLabelShowing {
                    titleFrame.origin.y = contentInsets
                        .top + (contentSize.height - titleFrame.height) / 2.0 + titleEdgeInsets.top
                }
                
            case .bottom:
                if isImageViewShowing {
                    imageFrame.origin.y = bounds.height - contentInsets.bottom - imageEdgeInsets
                        .bottom - imageFrame.height
                }
                if isTitleLabelShowing {
                    titleFrame.origin.y = bounds.height - contentInsets.bottom - titleEdgeInsets
                        .bottom - titleFrame.height
                }
                
            case .fill:
                if isImageViewShowing {
                    imageFrame.origin.y = contentInsets.top + imageEdgeInsets.top
                    imageFrame.size.height = contentSize.height - imageEdgeInsets.vertical
                }
                if isTitleLabelShowing {
                    titleFrame.origin.y = contentInsets.top + titleEdgeInsets.top
                    titleFrame.size.height = contentSize.height - titleEdgeInsets.vertical
                }

            default:
                break
            }
            
            if case .left = imagePosition {
                switch contentHorizontalAlignment {
                case .left:
                    if isImageViewShowing {
                        imageFrame.origin.x = contentInsets.left + imageEdgeInsets.left
                    }
                    if isTitleLabelShowing {
                        titleFrame.origin.x = contentInsets.left + imageTotalSize
                            .width + imageSpacing + titleEdgeInsets.left
                    }
                    
                case .center:
                    let contentWidth = imageTotalSize
                        .width + imageSpacing + titleTotalSize.width
                    let minX = contentInsets.left + (contentSize.width - contentWidth) / 2.0
                    if isImageViewShowing {
                        imageFrame.origin.x = minX + imageEdgeInsets.left
                    }
                    if isTitleLabelShowing {
                        titleFrame.origin.x = minX + imageTotalSize.width + imageSpacing + titleEdgeInsets.left
                    }
                    
                case .right:
                    if
                        imageTotalSize.width + imageSpacing + titleTotalSize
                            .width > contentSize.width {
                        if isImageViewShowing {
                            imageFrame.origin.x = contentInsets.left + imageEdgeInsets.left
                        }
                        if isTitleLabelShowing {
                            titleFrame.origin.x = contentInsets.left + imageTotalSize
                                .width + imageSpacing + titleEdgeInsets.left
                        }
                        
                    } else {
                        if isTitleLabelShowing {
                            titleFrame.origin.x = bounds.width - contentInsets.right - titleEdgeInsets
                                .right - titleFrame.width
                        }
                        if isImageViewShowing {
                            imageFrame.origin.x = bounds.width - contentInsets.right - titleTotalSize
                                .width - imageSpacing - imageTotalSize
                                .width + imageEdgeInsets.left
                        }
                    }
                    
                case .fill:
                    if isImageViewShowing, isTitleLabelShowing {
                        imageFrame.origin.x = contentInsets.left + imageEdgeInsets.left
                        titleFrame.origin.x = contentInsets.left + imageTotalSize.width + imageSpacing + titleEdgeInsets
                            .left
                        titleFrame.size.width = bounds.width - contentInsets.right - titleEdgeInsets.right - titleFrame
                            .minX
                    } else if isImageViewShowing {
                        imageFrame.origin.x = contentInsets.left + imageEdgeInsets.left
                        imageFrame.size.width = contentSize.width - imageEdgeInsets.horizontal
                    } else {
                        titleFrame.origin.x = contentInsets.left + titleEdgeInsets.left
                        titleFrame.size.width = contentSize.width - titleEdgeInsets.horizontal
                    }

                default:
                    break
                }
            } else {
                switch contentHorizontalAlignment {
                case .left:
                    if
                        imageTotalSize.width + imageSpacing + titleTotalSize
                            .width > contentSize.width {
                        if isImageViewShowing {
                            imageFrame.origin.x = bounds.width - contentInsets.right - imageEdgeInsets
                                .right - imageFrame.width
                        }
                        if isTitleLabelShowing {
                            titleFrame.origin.x = bounds.width - contentInsets.right - imageTotalSize
                                .width - imageSpacing - titleTotalSize
                                .width + titleEdgeInsets.left
                        }
                    } else {
                        if isTitleLabelShowing {
                            titleFrame.origin.x = contentInsets.left + titleEdgeInsets.left
                        }
                        if isImageViewShowing {
                            imageFrame.origin.x = contentInsets.left + titleTotalSize
                                .width + imageSpacing + imageEdgeInsets.left
                        }
                    }
                    
                case .center:
                    let contentWidth = imageTotalSize
                        .width + imageSpacing + titleTotalSize.width
                    let minX = contentInsets.left + (contentSize.width - contentWidth) / 2
                    if isTitleLabelShowing {
                        titleFrame.origin.x = minX + titleEdgeInsets.left
                    }
                    if isImageViewShowing {
                        imageFrame.origin.x = minX + titleTotalSize.width + imageSpacing + imageEdgeInsets.left
                    }
                    
                case .right:
                    if isImageViewShowing {
                        imageFrame.origin.x = bounds.width - contentInsets.right - imageEdgeInsets
                            .right - imageFrame.width
                    }
                    if isTitleLabelShowing {
                        titleFrame.origin.x = bounds.width - contentInsets.right - imageTotalSize
                            .width - imageSpacing - titleEdgeInsets
                            .right - titleFrame
                            .width
                    }
                    
                case .fill:
                    if isImageViewShowing, isTitleLabelShowing {
                        imageFrame.origin.x = bounds.width - contentInsets.right - imageEdgeInsets
                            .right - imageFrame.width
                        titleFrame.origin.x = contentInsets.left + titleEdgeInsets.left
                        titleFrame.size.width = imageFrame.minX - imageEdgeInsets
                            .left - imageSpacing - titleEdgeInsets
                            .right - titleFrame
                            .minX
                    } else if isImageViewShowing {
                        imageFrame.origin.x = contentInsets.left + imageEdgeInsets.left
                        imageFrame.size.width = contentSize.width - imageEdgeInsets.horizontal
                    } else {
                        titleFrame.origin.x = contentInsets.left + titleEdgeInsets.left
                        titleFrame.size.width = contentSize.width - titleEdgeInsets.horizontal
                    }

                default:
                    break
                }
            }
            
            if isImageViewShowing {
                _imageView?.frame = imageFrame
            }
            
            if isTitleLabelShowing {
                titleLabel?.frame = titleFrame
            }
        }
    }

    // MARK: Functions

    open func setup() {
        contentInsets = UIEdgeInsets(
            top: .leastNormalMagnitude,
            left: 0,
            bottom: .leastNormalMagnitude,
            right: 0
        )
    }
}
