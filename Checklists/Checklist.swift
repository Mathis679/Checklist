//
//  Checklist.swift
//  Checklists
//
//  Created by iem on 09/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import Foundation

class Checklist: NSObject, NSCoding{
    
    var name: String
    
    var items: [ChecklistItem]
    
    var iconName: String
    
    override init(){
        self.name = ""
        self.items = []
        self.iconName = ""
    }
    
    init(name: String, items: [ChecklistItem] = []){
        self.name = name
        self.items = items
        self.iconName = "No Icon"
    }
    
    init(name: String, items: [ChecklistItem] = [], iconName: String){
        self.name = name
        self.items = items
        self.iconName = iconName
    }
    
    // MARK: NSCoding
    
    required convenience init(coder decoder: NSCoder) {
        
        let name = decoder.decodeObject(forKey: "name") as? String
        let items = decoder.decodeObject(forKey: "items") as? [ChecklistItem]
        let iconName = decoder.decodeObject(forKey: "iconName") as? String
        
        self.init(
            name: name!,
            items: items!,
            iconName: iconName!
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.items, forKey: "items")
        coder.encode(self.iconName, forKey: "iconName")
        
    }
    
    func countChecked()->Int{
        var count = 0
        for item in items {
            if(item.checked){
                count = count + 1
            }
        }
        return count
    }

    
}
