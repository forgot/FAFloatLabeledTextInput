//
//  TableViewController.swift
//  FAFloatLabeledTextInput_Example
//
//  Created by Jesse Cox on 2/7/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import FAFloatLabeledTextInput

class TableViewController: UITableViewController {

    var fields: [TextInput] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        fields.forEach { field in
            if field is FAFloatLabelTextField {
                (field as! FAFloatLabelTextField).text = ""
                (field as! FAFloatLabelTextField).resignFirstResponder()
            } else {
                (field as! FAFloatLabelTextView).clear()
                (field as! FAFloatLabelTextView).resignFirstResponder()
            }
        }
        tableView.reloadData()
        super.viewDidDisappear(animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return configureTextField(tableView: tableView, indexPath: indexPath, placeholder: "This Is A TextField")
        case 1:
            return configureTextView(tableView: tableView, indexPath: indexPath, placeholder: "This Is A TextView")
        case 2:
            return configureTextField(tableView: tableView, indexPath: indexPath, placeholder: "This Is Another TextField")
        case 3:
            return configureTextView(tableView: tableView, indexPath: indexPath, placeholder: "This Is Another TextView")
        default:
            return UITableViewCell()
        }
    }

}


extension TableViewController {
    
    func configureTextField(tableView: UITableView, indexPath: IndexPath, placeholder: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Text Field", for: indexPath) as! FAFloatLabeledTextFieldTableViewCell
        cell.textField.placeholder = placeholder
        cell.textField.keepBaseline = true
        cell.textField.animateWhenFirstResponder = true
        fields.append(cell.textField)
        return cell
    }
    
    func configureTextView(tableView: UITableView, indexPath: IndexPath, placeholder: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Text View", for: indexPath) as! FAFloatLabeledTextViewTableViewCell
        cell.textView.placeholder = placeholder
        cell.textView.animateWhenFirstResponder = true
        fields.append(cell.textView)
        return cell
    }

}

protocol TextInput {}
extension FAFloatLabelTextField: TextInput {}
extension FAFloatLabelTextView: TextInput {}
