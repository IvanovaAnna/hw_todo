//
//  ShoppingListViewController.swift
//  hw_lecture_6
//
//  Created by Anna on 30.06.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {
    @IBOutlet weak var ShoppingListTextField: UITextField!
    @IBOutlet weak var ShoppingListTable: UITableView!

    let shoppingListData = ShoppingListItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let downloadDataFromUserDefaults = UserDefaults.standard.value(forKey: shoppingListData.dataKey) as? [String] {
            shoppingListData.shoppingArray = downloadDataFromUserDefaults
        }
        //Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingListData.shoppingArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCellIdentifier", for: indexPath)
        cell.textLabel?.text = shoppingListData.shoppingArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                cell.textLabel?.textColor = UIColor.black
            } else {
                cell.accessoryType = .checkmark
                cell.textLabel?.textColor = UIColor.lightGray
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < shoppingListData.shoppingArray.count {
            shoppingListData.shoppingArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
}
extension ShoppingListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textInTextField = textField.text {
            shoppingListData.shoppingArray.append(textInTextField)
            self.ShoppingListTable.reloadData()
            UserDefaults.standard.set(shoppingListData.shoppingArray, forKey: shoppingListData.dataKey)
        }
        ShoppingListTextField.text = ""
        ShoppingListTextField.resignFirstResponder()
        return true
    }
}
