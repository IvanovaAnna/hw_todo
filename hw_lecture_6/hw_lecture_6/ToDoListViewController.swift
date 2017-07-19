//
//  ToDoListViewController.swift
//  hw_lecture_6
//
//  Created by Anna on 30.06.17.
//  Copyright © 2017 Anna. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {
    @IBOutlet weak var toDoListTable: UITableView!
    @IBOutlet weak var toDoListTextField: UITextField!
    //var todoArray = [String]()
    
    let toDoData = ToDoItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let downloadDataFromUserDefaults = UserDefaults.standard.value(forKey: toDoData.dataKey) as? [String] {
            toDoData.todoArray = downloadDataFromUserDefaults
            //todoArray = downloadDataFromUserDefaults
        }
        //Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoData.todoArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCellIdentifier", for: indexPath)
        cell.textLabel?.text = toDoData.todoArray[indexPath.row]
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
        if indexPath.row < toDoData.todoArray.count {
            toDoData.todoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
}
extension ToDoListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textInTextField = textField.text {
            toDoData.todoArray.append(textInTextField)
            self.toDoListTable.reloadData()
            UserDefaults.standard.set(toDoData.todoArray, forKey: toDoData.dataKey)
        }
        toDoListTextField.text = ""
        toDoListTextField.resignFirstResponder()
        return true
    }
}
