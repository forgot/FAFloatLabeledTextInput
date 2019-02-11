//
//  FAFloatLabelTextField.swift
//  FAFloatLabelTextInput
//
//  Created by Jesse Cox on 1/24/19.
//  Copyright © 2019 Apprhythmia LLC. All rights reserved.
//

import UIKit


// MARK: - Class Declaration -

public class FAFloatLabelTextField: UITextField {
    
    // MARK: - Properties
    
    /// Read-only access to the floating label.
    public let floatingLabel: UILabel = UILabel()
    
    /// Backing property for placeholder.
    private var placeholderText: String? {
        didSet {
            if floatingTitle == nil && attributedFloatingTitle == nil {
                floatingLabel.text = placeholderText
                floatingLabel.sizeToFit()
            }
        }
    }
    
    /// Backing property for attributedPlaceholder.
    private var attributedPlaceholderText: NSAttributedString?
    
    /// Color of the placeholder.
    public var placeholderColor: UIColor?
    
    /// Font to be applied to the placeholder.
    public var placeholderFont: UIFont = .systemFont(ofSize: 14.0) {
        didSet {
            font = placeholderFont
        }
    }
    
    /// The string to be shown above the text field once it has been populated with text by the user.
    public var floatingTitle: String? {
        didSet {
            if attributedFloatingTitle == nil {
                floatingLabel.text = floatingTitle
                floatingLabel.sizeToFit()
            }
        }
    }
    
    /// The attributed string to be shown above the text field once it has been populated with text by the user.
    public var attributedFloatingTitle: NSAttributedString? {
        didSet {
            floatingLabel.attributedText = attributedFloatingTitle
            floatingLabel.sizeToFit()
        }
    }
    
    /// Font to be applied to the floating label.
    public var floatingLabelFont: UIFont = .systemFont(ofSize: 12.0) {
        didSet {
            floatingLabel.font = floatingLabelFont
            floatingLabel.sizeToFit()
        }
    }
    
    /// Text color to be applied to the floating label. Defaults to `UIColor.gray`.
    public var floatingLabelTextColor: UIColor = .gray {
        didSet {
            if !isFirstResponder {
                floatingLabel.textColor = floatingLabelTextColor
            }
        }
    }
    
    /// Text color to be applied to the floating label while the field is a first responder.
    ///
    /// Tint color is used by default if an `floatingLabelActiveTextColor` is not provided.
    public var floatingLabelActiveTextColor: UIColor? {
        didSet {
            if isFirstResponder {
                floatingLabel.textColor = floatingLabelActiveTextColor
            }
        }
    }

    /// Duration of the animation when showing the floating label. Defaults to 0.3 seconds.
    public var floatingLabelShowAnimationDuration: TimeInterval = 0.2
    
    /// Duration of the animation when hiding the floating label. Defaults to 0.3 seconds.
    public var floatingLabelHideAnimationDuration: TimeInterval = 0.3
    
    /// Indicates if the floating label should appear when the user selects the text field. Defaults to `false`.
    ///
    /// If set to `true`, the floating label will appear and the placeholder will dissapear
    /// when the text field becomes the first responder.
    public var animateWhenFirstResponder: Bool = false
    
    /// Padding to be applied to the y coordinate of the placeholder. Defaults to zero.
    public var placeholderYPadding: CGFloat = 0.0
    
    /// Padding to be applied to the y coordinate of the floating label upon presentation. Defaults to zero.
    public var floatingLabelYPadding: CGFloat = 0.0 {
        didSet {
            floatingLabel.frame.origin.y = floatingLabelYPadding
        }
    }
    
    /// Padding to be applied to the x coordinate of the floating label upon presentation. Defaults to zero.
    public var floatingLabelXPadding: CGFloat = 0.0 {
        didSet {
            floatingLabel.frame.origin.x = floatingLabelXPadding
        }
    }
    
    /// Indicates whether or not to drop the baseline when entering text.
    ///
    /// Setting to `true` (not the default) means the standard greyed-out placeholder will be aligned with the entered text.
    /// Defaults to `false` (standard placeholder will be above whatever text is entered)
    public var keepBaseline: Bool = false
    
    // MARK: Property Overrides

    /// The string that is displayed when there is no other text in the text field.
    override public var placeholder: String? {
        didSet {
            if let placeholder = placeholder {
                placeholderText = placeholder
            }
        }
    }
    
    /// The styled string that is displayed when there is no other text in the text field.
    override public var attributedPlaceholder: NSAttributedString? {
        didSet {
            attributedPlaceholderText = attributedPlaceholder
        }
    }
    
    /// The natural size for the receiving view, considering only properties of the view itself.
    override public var intrinsicContentSize: CGSize {
        var height: CGFloat = textRect(forBounds: superview!.bounds).height
        if let text = text, (animateWhenFirstResponder && isFirstResponder) || !text.isEmpty || keepBaseline {
            height += (floatingLabel.frame.height + floatingLabelYPadding)
        }
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    // MARK: - Method Overrides
    
    // MARK: Layout
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setTitlePositionForTextAlignment()
        
        if animateWhenFirstResponder {
            if let text = text, !text.isEmpty {
                showTitle(animated: false)
            } else {
                isFirstResponder ? showTitle(animated: true) : hideTitle(animated: true)
            }
            floatingLabel.textColor = isFirstResponder ? floatingLabelActiveTextColor : floatingLabelTextColor
        } else {
            if let text = text, !text.isEmpty && isFirstResponder {
                floatingLabel.textColor = floatingLabelActiveTextColor
            } else {
                floatingLabel.textColor = floatingLabelTextColor
            }
            
            if let text = text, text.isEmpty {
                hideTitle(animated: isFirstResponder)
            } else {
                showTitle(animated: isFirstResponder)
            }
        }
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        
        guard let text = text else {
            return rect
        }
        
        if (animateWhenFirstResponder && isFirstResponder) || !text.isEmpty || keepBaseline {
            var top = ceil(floatingLabel.bounds.size.height + placeholderYPadding)
            top = min(top, maxTopInset())
            rect = rect.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return rect.integral
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        
        guard let text = text else {
            return rect
        }
        
        if (animateWhenFirstResponder && isFirstResponder) || !text.isEmpty || keepBaseline {
            var top = ceil(floatingLabel.font.lineHeight + placeholderYPadding)
            top = min(top, maxTopInset())
            rect = rect.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        
        return rect.integral
    }
    
    override public func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.clearButtonRect(forBounds: bounds)
        
        guard let text = text else {
            return rect
        }
        
        if (animateWhenFirstResponder && isFirstResponder) || !text.isEmpty || keepBaseline {
            var top = ceil(floatingLabel.font.lineHeight + placeholderYPadding)
            top = min(top, maxTopInset())
            rect.origin.y = rect.origin.y + (top * 0.5)
        }
        
        return rect.integral
    }
    
}


// MARK: - Custom Implementation -

// MARK: Class Methods

extension FAFloatLabelTextField {
    
    /// Helper function called by all initializers to setup common state.
    private func commonInit() {
        borderStyle = .none
        floatingLabelActiveTextColor = tintColor
        floatingLabel.alpha = 0.0
        floatingLabel.font = floatingLabelFont
        floatingLabel.textColor = floatingLabelTextColor
        if let placeholder = placeholder, !placeholder.isEmpty {
            if attributedFloatingTitle == nil {
                floatingLabel.text = placeholder
            } else {
                floatingLabel.attributedText = attributedFloatingTitle!
            }
            floatingLabel.sizeToFit()
        }
        font = placeholderFont
        addSubview(floatingLabel)
    }
    
    /// Calculates the maximum top inset.
    private func maxTopInset() -> CGFloat {
        return font == nil ? 0.0 : max(0, floor(bounds.height - font!.lineHeight - 4.0))
    }
    
    /// Correctly updates the placeholder.
    private func updatePlaceholder() {
        
        if attributedPlaceholderText != nil {
            attributedPlaceholder = attributedPlaceholderText
        } else {
            if let placeholder = placeholderText {
                var attributes = [NSAttributedString.Key: Any]()
                attributes[.font] = placeholderFont
                attributes[.foregroundColor] = placeholderColor
                super.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
            }
        }

    }
    
    /// Sets the floating label's position for the current text alignment.
    private func setTitlePositionForTextAlignment() {
        let rect = textRect(forBounds: bounds)
        
        switch textAlignment {
        case .center, .right:
            floatingLabel.frame.origin.x = (rect.origin.x + (rect.width * (textAlignment == .center ? 0.5 : 1.0)) - floatingLabel.frame.width) + floatingLabelXPadding
        default:
            break
        }
    }
    
    /// Called to display the floating label.
    ///
    /// - Parameter animated: A Bool indicating if the change should be animated
    private func showTitle(animated:Bool) {
        let animations: () -> () = {
            self.floatingLabel.alpha = 1.0
            self.floatingLabel.frame.origin.y = self.floatingLabelYPadding
        }
        
        placeholder = nil
        UIView.animate(withDuration: animated ? floatingLabelShowAnimationDuration : 0,
                       delay: 0,
                       options: [.beginFromCurrentState, .curveEaseOut],
                       animations: animations,
                       completion: nil)
        
    }
    
    /// Called to hide the floating label.
    ///
    /// - Parameter animated: A Bool indicating if the change should be animated
    private func hideTitle(animated:Bool) {
        let animations: () -> () = {
            self.floatingLabel.alpha = 0.0
            self.floatingLabel.frame.origin.y = self.floatingLabel.font.lineHeight + self.placeholderYPadding
        }
        
        updatePlaceholder()
        UIView.animate(withDuration: animated ? floatingLabelHideAnimationDuration : 0,
                       delay: 0,
                       options: [.beginFromCurrentState, .curveEaseIn],
                       animations: animations,
                       completion: nil)
        
    }

}
