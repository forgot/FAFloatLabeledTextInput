//
//  FAFloatLabeledTextFieldTableViewCell.swift
//  FAFloatLabelTextInput
//
//  Created by Jesse Cox on 1/26/19.
//  Copyright © 2019 Apprhythmia LLC. All rights reserved.
//

import UIKit


// MARK: - Class Declaration -

open class FAFloatLabeledTextFieldTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    /// Read only access to the cells text field.
    public let textField =  FAFloatLabelTextField(frame: .zero)

    /// The UITableView that is displaying the cell, if any.
    public var tableView: UITableView? {
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

extension FAFloatLabeledTextFieldTableViewCell {
    
    /// Helper function called by all initializers to setup common state.
    private func commonInit() {
        
        /// Helper function called by `commonInit()` to setup constraints.
        func setupConstraints() {
            contentView.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
            contentView.heightAnchor.constraint(equalTo: textField.heightAnchor, constant: 0).isActive = true
        }
        
        setupConstraints()
        contentView.layoutIfNeeded()
    }
    
}
