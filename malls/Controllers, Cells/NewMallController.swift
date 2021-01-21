//
//  NewMallController.swift
//  malls
//
//  Created by Anna Nosyk on 21.01.2021.
//

import UIKit

class NewMallController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

    
    }
    // MARK: - TableView Delegate
    
    // hide keyboard tap outside row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        } else {
            view.endEditing(true)
        }
    }

}

// MARK: - TextField Delegate

extension NewMallController: UITextFieldDelegate {
    
    // hide keyboard (btn "Done")
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
