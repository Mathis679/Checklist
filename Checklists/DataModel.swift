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
    
    var table: [Checklist] = []
    
    private init() {
    
        loadChecklists()
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(DataModel.saveChecklists),
            name: .UIApplicationDidEnterBackground,
            object: nil)
        
       
        
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
    
    
    
    @objc func saveChecklists(){
        
        NSKeyedArchiver.archiveRootObject(table, toFile: dataFileUrl().absoluteString)
        
    }
    
    func loadChecklists(){
        if(NSKeyedUnarchiver.unarchiveObject(withFile: dataFileUrl().absoluteString) != nil){
            table = NSKeyedUnarchiver.unarchiveObject(withFile: dataFileUrl().absoluteString) as! [Checklist]
        }else{
            table = []
        }
        
    }
    
    func sortChecklists(){
        
        table.sort{sortFunc(checklist1: $0, checklist2: $1)}
        
    }
    
    func sortFunc(checklist1: Checklist,checklist2: Checklist)->Bool{
        if(checklist1.name.localizedStandardCompare(checklist2.name).rawValue == -1){ //checklist1 > checklist2
            return true
        }else if(checklist1.name.localizedStandardCompare(checklist2.name).rawValue == 0){ //checklist1 == checklist2
            return false
        }else if(checklist1.name.localizedStandardCompare(checklist2.name).rawValue == 0){ //checklist1 < checklist2
            return false
        }
        return false
    }
    
}
