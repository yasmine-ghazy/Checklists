//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Yasmine Ghazy on 7/21/18.
//  Copyright © 2018 Yasmine Ghazy. All rights reserved.
//

import Foundation

class ChecklistItem{
    var text = ""
    var checked = false
    
    init(_ text: String, _ checked: Bool){
        self.text = text
        self.checked = checked
    }
    func toggleChecked(){
        checked = !checked
    }
}
