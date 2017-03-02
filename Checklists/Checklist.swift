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
    
    override init(){
        self.name = ""
        self.items = []
    }
    
    init(name: String, items: [ChecklistItem] = []){
        self.name = name
        self.items = items
    }
    
    // MARK: NSCoding
    
    required convenience init(coder decoder: NSCoder) {
        
        let name = decoder.decodeObject(forKey: "name") as? String
        let items = decoder.decodeObject(forKey: "items") as? [ChecklistItem]
        
        self.init(
            name: name!,
            items: items!
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.items, forKey: "items")
        
    }

    
}
