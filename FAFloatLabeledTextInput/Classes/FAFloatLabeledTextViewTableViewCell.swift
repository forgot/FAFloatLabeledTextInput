//
//  FAFloatLabeledTextViewTableViewCell.swift
//  FAFloatLabelTextInput
//
//  Created by Jesse Cox on 1/26/19.
//  Copyright © 2019 Apprhythmia LLC. All rights reserved.
//

import UIKit


// MARK: - Class Declaration -

open class FAFloatLabeledTextViewTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    /// Read only access to the cells text view.
    public let textView = FAFloatLabelTextView(frame: .zero)
    
    /// The UITableView that is displaying the cell, if any.
    var tableView: UITableView? {
        get {
            var table: UIView? = superview
            
            while !(table is UITableView) && table != nil {
                table = table?.superview
            }
            
            return table as? UITableView
        }
    }
    
    // MARK: - Initializers

    override open func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

}

// MARK: - Custom Implementation -

// MARK: General

extension FAFloatLabeledTextViewTableViewCell {
    
    /// Helper function called by all initializers to setup common state.
    private func commonInit() {
        
        /// Helper function called by `commonInit()` to setup constraints.
        func setupConstriants() {
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        }
        
        /// Helper function called by `commonInit()` to register observers.
        func registerObservers() {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(resize),
                                                   name: UITextView.textDidChangeNotification,
                                                   object: textView)
        }
        
        contentView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        setupConstriants()
        registerObservers()
        textView.isScrollEnabled = false
        contentView.layoutIfNeeded()
    }
    
    /// Called to resize the cell to accommodate the text view.
    @objc private func resize() {
        let size = textView.bounds.size
        let newSize = textView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        
        let shouldAnimate = textView.text.isEmpty ? true : false
        
        // Resize the cell only when cell's size is changed
        if size.height != newSize.height {
            if !shouldAnimate {
                UIView.setAnimationsEnabled(false)
            }
            tableView?.beginUpdates()
            tableView?.endUpdates()
            if !shouldAnimate {
                UIView.setAnimationsEnabled(true)
            }
            
            if let thisIndexPath = tableView?.indexPath(for: self) {
                tableView?.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
        
    }

}
