//
//  FAFloatLabelTextView.swift
//  FAFloatLabelTextInput
//
//  Created by Jesse Cox on 1/24/19.
//  Copyright © 2019 Apprhythmia LLC. All rights reserved.
//

import UIKit

public class FAFloatLabelTextView: UITextView {
    
    // MARK: - Properties
    
    /// Read-only access to the floating label.
    public let floatingLabel: UILabel = UILabel()
    
    /// The title string to be shown in the floating label. Defaults to the placeholder string.
    public var floatingTitle: String = "" {
        didSet {
            floatingLabel.text = floatingTitle.isEmpty ? placeholder : floatingTitle
        }
    }
    
    /// Font to be applied to the floating label. Defaults to `UIFont.systemFont(ofSize: 12.0)`.
    public var floatingLabelFont: UIFont = .systemFont(ofSize: 12.0) {
        didSet {
            floatingLabel.font = floatingLabelFont
        }
    }
    
    /// Text color to be applied to the floating label while the text view is not a first responder.
    /// Defaults to `UIColor.gray`.
    public var floatingLabelTextColor: UIColor = .gray {
        didSet {
            if !isFirstResponder {
                floatingLabel.textColor = floatingLabelTextColor
            }
        }
    }
    
    /// Text color to be applied to the floating label while the text view is a first responder.
    /// Tint color is used by default if an `floatingLabelActiveTextColor` is not provided.
    public var floatingLabelActiveTextColor: UIColor?
    
    /// Read-only access to the placeholder label.
    public let placeholderLabel: UILabel = UILabel()
    
    /// The placeholder string to be shown in the text view when no other text is present.
    public var placeholder: String = "" {
        didSet {
            floatingLabel.text = floatingTitle.isEmpty ? placeholder : floatingTitle
            floatingLabel.sizeToFit()
            floatingLabel.frame.size.width = frame.width
            placeholderLabel.text = placeholder
        }
    }
    
    /// Font to be applied to the placeholder. Defaults to `UIFont.systemFont(ofSize: 14.0)`.
    public var placeholderFont: UIFont = .systemFont(ofSize: 14.0) {
        didSet {
            placeholderLabel.font = placeholderFont
        }
    }
    
    /// Text color to be applied to the placeholder.
    /// Defaults to `UIColor.lightGray.withAlphaComponent(0.65)`.
    public var placeholderTextColor: UIColor = UIColor.lightGray.withAlphaComponent(0.65)

    /// Duration of the animation when showing the floating label. Defaults to 0.3 seconds.
    public var floatingLabelShowAnimationDuration: TimeInterval = 0.3
    
    /// Duration of the animation when hiding the floating label. Defaults to 0.3 seconds.
    public var floatingLabelHideAnimationDuration: TimeInterval = 0.2
    
    /// Indicates if the floating label should appear when the user selects the text field. Defaults to `false`.
    ///
    /// If set to `true`, the floating label will appear and the placeholder will dissapear
    /// when the text field becomes the first responder.
    public var animateWhenFirstResponder: Bool = false
    
    /// Top value for textContainerInset. Change this value if you need more padding between text input and floating label.
    public var startingTextContainerInsetTop: CGFloat = 0.0
    
    /// Padding to be applied to the y coordinate of the placeholder.
    public var placeholderYPadding: CGFloat = 0.0 {
        didSet {
            adjustTextContainerInsetTop()
        }
    }
    
    /// Padding to be applied to the y coordinate of the floating label upon presentation.
    public var floatingLabelYPadding: CGFloat = 0.0 {
        didSet {
            floatingLabel.frame.origin.y = floatingLabelYPadding
        }
    }
    
    /// Padding to be applied to the x coordinate of the floating label upon presentation.
    public var floatingLabelXPadding: CGFloat = 0.0
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    // MARK: - Method Overrides
    
    // MARK: Layout
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        adjustTextContainerInsetTop()
        
        let placeholderLabelSize = placeholderLabel.sizeThatFits(placeholderLabel.superview!.bounds.size)

        
        let textRect = getTextRect()
        placeholderLabel.frame = CGRect(x: textRect.origin.x,
                                        y: textRect.origin.y,
                                        width: placeholderLabelSize.width,
                                        height: placeholderLabelSize.height)
        
        setTitlePositionForTextAlignment()
        
        if animateWhenFirstResponder {
            placeholderLabel.alpha = !text.isEmpty || isFirstResponder ? 0.0 : 1.0
            floatingLabel.textColor = isFirstResponder ? labelActiveColor() : floatingLabelTextColor
            !text.isEmpty || isFirstResponder ? showTitle(animated: true) : hideTitle(animated: true)
        } else {
            placeholderLabel.alpha = text.isEmpty ? 1.0 : 0.0
            floatingLabel.textColor = isFirstResponder && !text.isEmpty ? labelActiveColor() : floatingLabelTextColor
            text.isEmpty ? hideTitle(animated: true) : showTitle(animated: true)
        }
    }
    
}


// MARK: - Custom Implementation -

// MARK: Class Methods

extension FAFloatLabelTextView {
    
    /// Helper function called by all initializers to setup common state.
    private func commonInit() {
        
        /// Helper function called by `commonInit()` to register observers.
        func registerObservers() {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(UIView.layoutSubviews),
                                                   name: UITextView.textDidChangeNotification,
                                                   object: self)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(UIView.layoutSubviews),
                                                   name: UITextView.textDidBeginEditingNotification,
                                                   object: self)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(UIView.layoutSubviews),
                                                   name: UITextView.textDidEndEditingNotification,
                                                   object: self)
        }

        
        startingTextContainerInsetTop = textContainerInset.top
        textContainer.lineFragmentPadding = 0.0
        
        // Placeholder
        placeholderLabel.font = placeholderFont
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = 0
        placeholderLabel.lineBreakMode = .byWordWrapping
        placeholderLabel.backgroundColor = .clear
        placeholderLabel.textColor = placeholderTextColor
        insertSubview(placeholderLabel, at: 0)
        
        // Title
        floatingLabel.alpha = 0.0
        floatingLabel.font = floatingLabelFont
        floatingLabel.textColor = floatingLabelTextColor
        floatingLabel.backgroundColor = backgroundColor
        if !placeholder.isEmpty {
            floatingLabel.text = placeholder
            floatingLabel.sizeToFit()
        }
        addSubview(floatingLabel)
        floatingLabelActiveTextColor = tintColor
        registerObservers()
    }
    
    /// Adjusts the top edge of the text view's `textContainerInset`.
    private func adjustTextContainerInsetTop() {
        textContainerInset.top = startingTextContainerInsetTop + floatingLabel.font.lineHeight + placeholderYPadding
    }
    
    /// Calculates the area in which the text is displayed in this text view.
    ///
    /// - Returns: A `CGRect` that is the integral of
    private func getTextRect() -> CGRect {
        var rect = bounds.inset(by: contentInset)
        rect.origin.x += textContainer.lineFragmentPadding
        rect.origin.y += textContainerInset.top
        return rect.integral
    }
    
    /// Sets the floating label's position for the current text alignment.
    private func setTitlePositionForTextAlignment() {
        var floatingLabelOriginX = getTextRect().origin.x
        var placeholderLabelX = floatingLabelOriginX
        
        switch textAlignment {
        case .center, .right:
            floatingLabelOriginX = frame.width - floatingLabel.frame.width
            placeholderLabelX = frame.width - placeholderLabel.frame.width
        default:
            return
        }
        
        floatingLabel.frame.origin.x = (textAlignment == .center ? floatingLabelOriginX * 0.5 : floatingLabelOriginX) + floatingLabelXPadding
        placeholderLabel.frame.origin.x = textAlignment == .center ? placeholderLabelX * 0.5 : placeholderLabelX
    }
    
    
    /// Called to determine the text color to use when the text view becomes active.
    ///
    /// - Returns: The text view's `floatingLabelActiveTextColor`, or `tint` if the former is `nil`. If both values return `nil`, it defaults to `.blue`
    private func labelActiveColor() -> UIColor {
        if floatingLabelActiveTextColor != nil {
            return floatingLabelActiveTextColor!
        } else if tintColor != nil {
            return tintColor
        }
        return .blue
    }
    
    /// Called to display the floating label
    ///
    /// - Parameter animated: A Bool indicating if the change should be animated
    private func showTitle(animated: Bool) {
        let animations: () -> () = {
            self.floatingLabel.alpha = 1.0
            self.floatingLabel.frame.origin.y = self.floatingLabelYPadding + self.contentOffset.y
        }
        
        UIView.animate(withDuration: animated ? floatingLabelShowAnimationDuration : 0,
                       delay: 0,
                       options: [.beginFromCurrentState, .curveEaseOut],
                       animations: animations,
                       completion: nil)
    }
    
    /// Called to hide the floating label
    ///
    /// - Parameter animated: A Bool indicating if the change should be animated
    private func hideTitle(animated: Bool) {
        let animations: () -> () = {
            self.floatingLabel.alpha = 0.0
            self.floatingLabel.frame.origin.y = self.floatingLabel.font.lineHeight + self.placeholderYPadding
        }
        
        UIView.animate(withDuration: animated ? floatingLabelHideAnimationDuration : 0,
                       delay: 0,
                       options: [.beginFromCurrentState, .curveEaseIn],
                       animations: animations,
                       completion: nil)
    }
    
}
