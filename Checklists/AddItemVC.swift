//
//  AddItemVCTableViewController.swift
//  Checklists
//
//  Created by Yasmine Ghazy on 7/22/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import UIKit

protocol AddItemVCDelegate: class{
    func addItemVCDidCancel(_ controller: AddItemVC)
    func addItemVC(_ controller: AddItemVC, didFinishAdding item: ChecklistItem)
}


class AddItemVC: UITableViewController , UITextFieldDelegate{

    @IBOutlet weak var itemTF : UITextField!
    @IBOutlet weak var doneBarBtn : UIBarButtonItem!
    weak var delegate: AddItemVCDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        itemTF.becomeFirstResponder()
        doneBarBtn.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    @IBAction func cancel(){
        delegate?.addItemVCDidCancel(self)
        //navigationController?.popViewController(animated: true)
    }
    
    @IBAction func done(){
        let itemText = itemTF.text!
        let item = ChecklistItem(itemText,false)
        delegate?.addItemVC(self, didFinishAdding: item)
        //navigationController?.popViewController(animated: true)
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range,
                                                  with: string) as NSString
        
        doneBarBtn.isEnabled = newText.length>0
        return true
    }
    
}
