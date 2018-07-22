//
//  ViewController.swift
//  Checklists
//
//  Created by Yasmine Ghazy on 7/21/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit

class ChecklistVC: UITableViewController, AddItemVCDelegate{
    // MARK:- Properties
    var items: [ChecklistItem]
  //  var delegate: AddItemVCDelegate
    
    // MARK:- Initialization
    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
        let list = ["Walk the dog", "Brush my teeth", "Learn iOS development", "Soccer practice", "Eat ice cream"]
        
        for itemText in list{
            let item = ChecklistItem(itemText,false)
            items.append(item)
        }
  //      self.delegate = delegate
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //TableView Delegate, DataSource Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
            let item = items[indexPath.row]
            configureText(for: cell, with: item)
            configureCheckmark(for: cell, with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for:cell , with:item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    //cell configuration
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem){
        if item.checked{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
    }
    
    func configureText(for cell: UITableViewCell,
                       with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    
    //AddItemVC Delegate Functions
    func addItemVCDidCancel(
        _ controller: AddItemVC) {
        
        dismiss(animated: true, completion: nil)
        
    }
    func addItemVC(_ controller: AddItemVC,
                               didFinishAdding item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"{
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddItemVC
            controller.delegate = self
            
        }
    }
}

