//
//  ComponentButton.swift
//  ComponentKit
//
//  Created by Sun on 2024/8/19.
//

import UIKit

import ThemeKit
import SnapKit

open class ComponentButton: UIButton {
    
    public enum ImagePosition {
        
        case top(CGFloat)
        case left(CGFloat)
        case bottom(CGFloat)
        case right(CGFloat)
        case none
        
        public var spacing: CGFloat {
            switch self {
            case .top(let value),
                    .left(let value),
                    .bottom(let value),
                    .right(let value):
                return value
            case .none:
                return 0
            }
        }
    }
    
    public static var height: CGFloat = .heightButton
    
    public var buttonHeight: CGFloat = ComponentButton.height
    
    public var hitTestInset: UIEdgeInsets?
    
    public var imagePosition: ImagePosition = .none {
        didSet {
            setNeedsLayout()
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        return self.sizeThatFits(CGSize(
            width: CGFloat.greatestFiniteMagnitude,
            height: CGFloat.greatestFiniteMagnitude
        ))
    }
    
    private var internalImageView: UIImageView? {
        let _imageView_ = perform(NSSelectorFromString("_imageView")).takeUnretainedValue()
        if let imageView = _imageView_ as? UIImageView {
            return imageView
        }
        return nil
    }
    
    public init(imagePosition: ImagePosition = .none) {
        self.imagePosition = imagePosition
        super.init(frame: .zero)
        
        self.setup()
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let inset = self.hitTestInset {
            return self.bounds.inset(by: inset).contains(point)
        }
        return super.point(inside: point, with: event)
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = size
        if self.bounds.size == size {
            newSize = CGSize(
                width: CGFloat.greatestFiniteMagnitude,
                height: CGFloat.greatestFiniteMagnitude
            )
        }
        
        let isImageViewShowing = self.currentImage != nil
        let isTitleLabelShowing = self.currentTitle != nil || currentAttributedTitle != nil
        
        var imageTotalSize: CGSize = .zero
        var titleTotalSize: CGSize = .zero
        let spacing: CGFloat = isImageViewShowing && isTitleLabelShowing ? self
            .imagePosition.spacing : 0
        
        let contentEdgeInsets = self.contentEdgeInsets
        var resultSize: CGSize = .zero
        let contentLimitSize = CGSize(
            width: newSize.width - contentEdgeInsets.horizontal,
            height: newSize.height - contentEdgeInsets.vertical
        )
        
        switch imagePosition {
        case .top, .bottom:
            if isImageViewShowing {
                let imageLimitWidth = contentLimitSize.width - imageEdgeInsets.horizontal
                var imageSize: CGSize = .zero
                if let imageView = imageView, imageView.image != nil {
                    imageSize = imageView
                        .sizeThatFits(CGSize(
                            width: imageLimitWidth,
                            height: .greatestFiniteMagnitude
                        ))
                } else {
                    if let currentImage = currentImage {
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
                            .height - spacing - titleEdgeInsets.vertical
                    )
                    
                    var titleSize: CGSize = .zero
                    if let titleLabel = titleLabel {
                        titleSize = titleLabel.sizeThatFits(titleLimitSize)
                    }
                    titleSize.height = .minimum(titleSize.height, titleLimitSize.height)
                    titleTotalSize = CGSize(
                        width: titleSize.width + titleEdgeInsets.horizontal,
                        height: titleSize.height + titleEdgeInsets.vertical
                    )
                }
                
                resultSize.width = contentEdgeInsets.horizontal
                resultSize.width += .maximum(imageTotalSize.width, titleTotalSize.width)
                resultSize.height = contentEdgeInsets.vertical + imageTotalSize
                    .height + spacing + titleTotalSize.height
            }
            
        case .left, .right, .none:
            if isImageViewShowing {
                let imageLimitHeight = contentLimitSize.height - imageEdgeInsets.vertical
                var imageSize: CGSize = .zero
                if let imageView = imageView, imageView.image != nil {
                    imageSize = imageView
                        .sizeThatFits(CGSize(
                            width: .greatestFiniteMagnitude,
                            height: imageLimitHeight
                        ))
                } else {
                    if let currentImage = currentImage {
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
                        .width - spacing,
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
            
            resultSize.width = contentEdgeInsets.horizontal + imageTotalSize
                .width + spacing + titleTotalSize.width
            resultSize.height = contentEdgeInsets.vertical
            resultSize.height += .maximum(imageTotalSize.height, titleTotalSize.height)
        }
        
        return resultSize
    }
    
    // swiftlint:disable function_body_length
    // swiftlint:disable cyclomatic_complexity
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        guard !bounds.isEmpty else { return }
        
        let isImageViewShowing = currentImage != nil
        let isTitleLabelShowing = currentTitle != nil || currentAttributedTitle != nil
        
        var imageLimitSize: CGSize = .zero
        var titleLimitSize: CGSize = .zero
        var imageTotalSize: CGSize = .zero
        var titleTotalSize: CGSize = .zero
        let spacing: CGFloat = (isImageViewShowing && isTitleLabelShowing) ?
        self.imagePosition.spacing : 0
        
        var imageFrame: CGRect = .zero
        var titleFrame: CGRect = .zero
        let contentEdgeInsets = self.contentEdgeInsets
        let contentSize = CGSize(
            width: bounds.width - contentEdgeInsets.horizontal,
            height: bounds.height - contentEdgeInsets.vertical
        )
        
        if isImageViewShowing {
            imageLimitSize = CGSize(
                width: contentSize.width - imageEdgeInsets.horizontal,
                height: contentSize.height - imageEdgeInsets.vertical
            )
            var imageSize: CGSize = .zero
            if let imageView = self.internalImageView, imageView.image != nil {
                imageSize = imageView.sizeThatFits(imageLimitSize)
            } else {
                if let currentImage = currentImage {
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
            if let imageView = self.internalImageView {
                ensureBoundsPositive(imageView)
            }
        }
        
        if isTitleLabelShowing {
            if let label = titleLabel {
                ensureBoundsPositive(label)
            }
        }
        
        switch imagePosition {
        case .top, .bottom:
            if isTitleLabelShowing {
                titleLimitSize = CGSize(
                    width: contentSize.width - titleEdgeInsets.horizontal,
                    height: contentSize.height - imageTotalSize
                        .height - spacing - titleEdgeInsets.vertical
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
                    imageFrame.origin.x = contentEdgeInsets.left + imageEdgeInsets.left
                }
                if isTitleLabelShowing {
                    titleFrame.origin.x = contentEdgeInsets.left + titleEdgeInsets.left
                }
                
            case .center:
                if isImageViewShowing {
                    imageFrame.origin.x = contentEdgeInsets.left + imageEdgeInsets.left + (imageLimitSize.width - imageFrame.width) / 2
                }
                if isTitleLabelShowing {
                    titleFrame.origin.x = contentEdgeInsets.left + titleEdgeInsets.left +
                    (titleLimitSize.width - titleFrame.width) / 2
                }
                
            case .right:
                if isImageViewShowing {
                    imageFrame.origin.x = bounds.width - contentEdgeInsets.right - imageEdgeInsets
                        .right - imageFrame.width
                }
                if isTitleLabelShowing {
                    titleFrame.origin.x = bounds.width - contentEdgeInsets.right - titleEdgeInsets
                        .right - titleFrame.width
                }
             
            case .fill:
                if isImageViewShowing {
                    imageFrame.origin.x = contentEdgeInsets.left + imageEdgeInsets.left
                    imageFrame.size.width = imageLimitSize.width
                }
                
                if isTitleLabelShowing {
                    titleFrame.origin.x = contentEdgeInsets.left + titleEdgeInsets.left
                    titleFrame.size.width = titleLimitSize.width
                }
                
            default: 
                break
            }
            
            if case .top = imagePosition {
                switch contentVerticalAlignment {
                case .top:
                    if isImageViewShowing {
                        imageFrame.origin.y = contentEdgeInsets.top + imageEdgeInsets.top
                    }
                    if isTitleLabelShowing {
                        titleFrame.origin.y = contentEdgeInsets.top + imageTotalSize
                            .height + spacing + titleEdgeInsets.top
                    }
                    
                case .center:
                    let contentHeight = imageTotalSize
                        .height + spacing + titleTotalSize.height
                    let minY = (contentSize.height - contentHeight) / 2 + contentEdgeInsets.top
                    if isImageViewShowing {
                        imageFrame.origin.y = minY + imageEdgeInsets.top
                    }
                    if isTitleLabelShowing {
                        titleFrame.origin.y = minY + imageTotalSize
                            .height + spacing + titleEdgeInsets.top
                    }
                    
                case .bottom:
                    if isTitleLabelShowing {
                        titleFrame.origin.y = bounds.height - contentEdgeInsets.bottom - titleEdgeInsets
                            .bottom - titleFrame.height
                    }
                    if isImageViewShowing {
                        imageFrame.origin.y = bounds.height - contentEdgeInsets.bottom - titleTotalSize
                            .height - spacing - imageEdgeInsets
                            .bottom - imageFrame
                            .height
                    }
                    
                case .fill:
                    if isImageViewShowing, isTitleLabelShowing {
                        if isImageViewShowing {
                            imageFrame.origin.y = contentEdgeInsets.top + imageEdgeInsets.top
                        }
                        if isTitleLabelShowing {
                            titleFrame.origin.y = contentEdgeInsets.top + imageTotalSize
                                .height + spacing + titleEdgeInsets.top
                            titleFrame.size.height = bounds.height - contentEdgeInsets.bottom - titleEdgeInsets
                                .bottom - titleFrame.minY
                        }
                    }
                    
                default: 
                    break
                }
            } else {
                switch contentVerticalAlignment {
                case .top:
                    if isTitleLabelShowing {
                        titleFrame.origin.y = contentEdgeInsets.top + titleEdgeInsets.top
                    }
                    if isImageViewShowing {
                        imageFrame.origin.y = contentEdgeInsets.top + titleTotalSize
                            .height + spacing + imageEdgeInsets.top
                    }
                    
                case .center:
                    let contentHeight = imageTotalSize.height + titleTotalSize
                        .height + spacing
                    let minY = (contentSize.height - contentHeight) / 2 + contentEdgeInsets.top
                    if isTitleLabelShowing {
                        titleFrame.origin.y = minY + titleEdgeInsets.top
                    }
                    if isImageViewShowing {
                        imageFrame.origin.y = minY + titleTotalSize
                            .height + spacing + imageEdgeInsets.top
                    }
                    
                case .bottom:
                    if isImageViewShowing {
                        imageFrame.origin.y = bounds.height - contentEdgeInsets.bottom - imageEdgeInsets
                            .bottom - imageFrame.height
                    }
                    if isTitleLabelShowing {
                        titleFrame.origin.y = bounds.height - contentEdgeInsets.bottom - imageTotalSize
                            .height - spacing - titleEdgeInsets
                            .bottom - titleFrame
                            .height
                    }
                    
                case .fill:
                    if isImageViewShowing, isTitleLabelShowing {
                        imageFrame.origin.y = bounds.height - contentEdgeInsets.bottom - imageEdgeInsets.bottom - imageFrame.height
                        titleFrame.origin.y = contentEdgeInsets.top + titleEdgeInsets.top
                        titleFrame.size.height = bounds.height - contentEdgeInsets.bottom - imageTotalSize.height - spacing - titleEdgeInsets.bottom - titleFrame.minY
                    } else if isImageViewShowing {
                        imageFrame.origin.y = contentEdgeInsets.top + imageEdgeInsets.top
                        imageFrame.size.height = contentSize.height - imageEdgeInsets.vertical
                    } else {
                        titleFrame.origin.y = contentEdgeInsets.top + titleEdgeInsets.top
                        titleFrame.size.height = contentSize.height - titleEdgeInsets.vertical
                    }
                    
                default:
                    break
                }
            }
            
            if isImageViewShowing {
                self.internalImageView?.frame = imageFrame
            }
            
            if isTitleLabelShowing {
                self.titleLabel?.frame = titleFrame
            }
            
        case .left, .right, .none:
            if isTitleLabelShowing {
                titleLimitSize = CGSize(
                    width: contentSize.width - titleEdgeInsets.horizontal - imageTotalSize
                        .width - spacing,
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
                    imageFrame.origin.y = contentEdgeInsets.top + imageEdgeInsets.top
                }
                if isTitleLabelShowing {
                    titleFrame.origin.y = contentEdgeInsets.top + titleEdgeInsets.top
                }
                
            case .center:
                if isImageViewShowing {
                    imageFrame.origin.y = contentEdgeInsets.top + (contentSize.height - imageFrame.height) / 2 + imageEdgeInsets.top
                }
                if isTitleLabelShowing {
                    titleFrame.origin.y = contentEdgeInsets.top + (contentSize.height - titleFrame.height) / 2 + titleEdgeInsets.top
                }
                
            case .bottom:
                if isImageViewShowing {
                    imageFrame.origin.y = bounds.height - contentEdgeInsets.bottom - imageEdgeInsets
                        .bottom - imageFrame.height
                }
                if isTitleLabelShowing {
                    titleFrame.origin.y = bounds.height - contentEdgeInsets.bottom - titleEdgeInsets.bottom - titleFrame.height
                }
                
            case .fill:
                if isImageViewShowing {
                    imageFrame.origin.y = contentEdgeInsets.top + imageEdgeInsets.top
                    imageFrame.size.height = contentSize.height - imageEdgeInsets.vertical
                }
                if isTitleLabelShowing {
                    titleFrame.origin.y = contentEdgeInsets.top + titleEdgeInsets.top
                    titleFrame.size.height = contentSize.height - titleEdgeInsets.vertical
                }
                
            default:
                break
            }
            
            if case .left = imagePosition {
                switch contentHorizontalAlignment {
                case .left:
                    if isImageViewShowing {
                        imageFrame.origin.x = contentEdgeInsets.left + imageEdgeInsets.left
                    }
                    if isTitleLabelShowing {
                        titleFrame.origin.x = contentEdgeInsets.left + imageTotalSize.width + spacing + titleEdgeInsets.left
                    }
                    
                case .center:
                    let contentWidth = imageTotalSize
                        .width + spacing + titleTotalSize.width
                    let minX = contentEdgeInsets.left + (contentSize.width - contentWidth) / 2
                    if isImageViewShowing {
                        imageFrame.origin.x = minX + imageEdgeInsets.left
                    }
                    if isTitleLabelShowing {
                        titleFrame.origin.x = minX + imageTotalSize.width + spacing + titleEdgeInsets.left
                    }
                    
                case .right:
                    if imageTotalSize.width + spacing + titleTotalSize
                        .width > contentSize.width
                    {
                        if isImageViewShowing {
                            imageFrame.origin.x = contentEdgeInsets.left + imageEdgeInsets.left
                        }
                        if isTitleLabelShowing {
                            titleFrame.origin.x = contentEdgeInsets.left + imageTotalSize
                                .width + spacing + titleEdgeInsets.left
                        }
                    } else {
                        if isTitleLabelShowing {
                            titleFrame.origin.x = bounds.width - contentEdgeInsets.right - titleEdgeInsets
                                .right - titleFrame.width
                        }
                        if isImageViewShowing {
                            imageFrame.origin.x = bounds.width - contentEdgeInsets.right - titleTotalSize
                                .width - spacing - imageTotalSize
                                .width + imageEdgeInsets.left
                        }
                    }
                    
                case .fill:
                    if isImageViewShowing, isTitleLabelShowing {
                        imageFrame.origin.x = contentEdgeInsets.left + imageEdgeInsets.left
                        titleFrame.origin.x = contentEdgeInsets.left + imageTotalSize.width + spacing + titleEdgeInsets.left
                        titleFrame.size.width = bounds.width - contentEdgeInsets.right - titleEdgeInsets.right - titleFrame.minX
                        
                    } else if isImageViewShowing {
                        imageFrame.origin.x = contentEdgeInsets.left + imageEdgeInsets.left
                        imageFrame.size.width = contentSize.width - imageEdgeInsets.horizontal
                    } else {
                        titleFrame.origin.x = contentEdgeInsets.left + titleEdgeInsets.left
                        titleFrame.size.width = contentSize.width - titleEdgeInsets.horizontal
                    }
                    
                default:
                    break
                }
            } else {
                switch contentHorizontalAlignment {
                case .left:
                    if imageTotalSize.width + spacing + titleTotalSize
                        .width > contentSize.width
                    {
                        if isImageViewShowing {
                            imageFrame.origin.x = bounds.width - contentEdgeInsets.right - imageEdgeInsets
                                .right - imageFrame.width
                        }
                        if isTitleLabelShowing {
                            titleFrame.origin.x = bounds.width - contentEdgeInsets.right - imageTotalSize
                                .width - spacing - titleTotalSize
                                .width + titleEdgeInsets.left
                        }
                    } else {
                        if isTitleLabelShowing {
                            titleFrame.origin.x = contentEdgeInsets.left + titleEdgeInsets.left
                        }
                        if isImageViewShowing {
                            imageFrame.origin.x = contentEdgeInsets.left + titleTotalSize
                                .width + spacing + imageEdgeInsets.left
                        }
                    }
                    
                case .center:
                    let contentWidth = imageTotalSize
                        .width + spacing + titleTotalSize.width
                    let minX = contentEdgeInsets.left + (contentSize.width - contentWidth) / 2
                    if isTitleLabelShowing {
                        titleFrame.origin.x = minX + titleEdgeInsets.left
                    }
                    if isImageViewShowing {
                        imageFrame.origin.x = minX + titleTotalSize
                            .width + spacing + imageEdgeInsets.left
                    }
                    
                case .right:
                    if isImageViewShowing {
                        imageFrame.origin.x = bounds.width - contentEdgeInsets.right - imageEdgeInsets.right - imageFrame.width
                    }
                    if isTitleLabelShowing {
                        titleFrame.origin.x = bounds.width - contentEdgeInsets.right - imageTotalSize
                            .width - spacing - titleEdgeInsets
                            .right - titleFrame
                            .width
                    }
                    
                case .fill:
                    if isImageViewShowing, isTitleLabelShowing {
                        imageFrame.origin.x = bounds.width - contentEdgeInsets.right - imageEdgeInsets.right - imageFrame.width
                        titleFrame.origin.x = contentEdgeInsets.left + titleEdgeInsets.left
                        titleFrame.size.width = imageFrame.minX - imageEdgeInsets
                            .left - spacing - titleEdgeInsets
                            .right - titleFrame
                            .minX
                        
                    } else if isImageViewShowing {
                        imageFrame.origin.x = contentEdgeInsets.left + imageEdgeInsets.left
                        imageFrame.size.width = contentSize.width - imageEdgeInsets.horizontal
                    } else {
                        titleFrame.origin.x = contentEdgeInsets.left + titleEdgeInsets.left
                        titleFrame.size.width = contentSize.width - titleEdgeInsets.horizontal
                    }
                    
                default: 
                    break
                }
            }
            
            if isImageViewShowing {
                self.internalImageView?.frame = imageFrame
            }
            
            if isTitleLabelShowing {
                self.titleLabel?.frame = titleFrame
            }
        }
    }
    
    open func setup() {
        self.contentEdgeInsets = UIEdgeInsets(
            top: .leastNormalMagnitude,
            left: 0,
            bottom: .leastNormalMagnitude,
            right: 0
        )
    }
}
