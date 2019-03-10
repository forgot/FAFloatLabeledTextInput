//
//  ViewController.swift
//  FAFloatLabeledTextInput
//
//  Created by forgot on 02/06/2019.
//  Copyright (c) 2019 forgot. All rights reserved.
//

import UIKit
import FAFloatLabeledTextInput

class ViewController: UIViewController {

    @IBOutlet weak var titleField: FAFloatLabelTextField!
    @IBOutlet weak var priceField: FAFloatLabelTextField!
    @IBOutlet weak var locationField: FAFloatLabelTextField!
    @IBOutlet weak var descriptionField: FAFloatLabelTextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        commonInit()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let fields: [TextInput] = [titleField, priceField, locationField, descriptionField]
        fields.forEach { field in
            if field is FAFloatLabelTextField {
                (field as! FAFloatLabelTextField).text = ""
                (field as! FAFloatLabelTextField).resignFirstResponder()
            } else {
                (field as! FAFloatLabelTextView).clear()
                (field as! FAFloatLabelTextView).resignFirstResponder()
            }
        }
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        commonInit()
    }
    
    func commonInit() {
        titleField.placeholder = "Title"
        titleField.placeholderFont = .systemFont(ofSize: 16.0)
        titleField.floatingLabelFont = .boldSystemFont(ofSize: 11.0)
        titleField.keepBaseline = true
        
        priceField.placeholder = "Price"
        priceField.placeholderFont = .systemFont(ofSize: 16.0)
        priceField.floatingLabelFont = .boldSystemFont(ofSize: 11.0)
        priceField.keepBaseline = true
        
        locationField.placeholder = "Specific Location (optional)"
        locationField.placeholderFont = .systemFont(ofSize: 16.0)
        locationField.floatingLabelFont = .boldSystemFont(ofSize: 11.0)
        locationField.keepBaseline = true

        descriptionField.placeholder = "Description"
        descriptionField.placeholderFont = .systemFont(ofSize: 16.0)
        descriptionField.floatingLabelFont = .boldSystemFont(ofSize: 11.0)

    }

}
