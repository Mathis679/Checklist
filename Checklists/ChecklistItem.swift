//
//  ChecklistItem.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import Foundation

class ChecklistItem {

    var text: String
    
    var checked: Bool
    
    init(text: String){
        self.text = text
        self.checked = false
    }
    
    init(text: String, checked: Bool){
        self.text = text
        self.checked = checked
    }
    
    func toggleChecked(){
        if(self.checked){
            self.checked = false
        }else{
            self.checked = true
        }
    }
    
}
