//
//  DataModel.swift
//  Checklists
//
//  Created by iem on 02/03/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import Foundation

class DataModel{
    
    static let sharedInstance = DataModel()
    
    private init() {
    
    }
    
    func documentDirectory() -> URL{
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
        let urlPath = URL(string: path)
        return urlPath!
        
    }
    
    func dataFileUrl() -> URL{
        let documentDirectory = self.documentDirectory()
        let path = documentDirectory.appendingPathComponent("/checklists.plist")
        return path
    }
    
    
    
    func saveChecklists(table: [Checklist]){
        
        NSKeyedArchiver.archiveRootObject(_: table, toFile: dataFileUrl().absoluteString)
        
    }
    
    func loadChecklists() -> [Checklist]{
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: dataFileUrl().absoluteString) as! [Checklist]
    }
}
