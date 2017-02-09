//
//  AllListViewController.swift
//  Checklists
//
//  Created by iem on 09/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

    var table = [Checklist(name: "testall1"), Checklist(name: "testall2"), Checklist(name: "testall3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Checklists"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let targetController = segue.destination as! ChecklistViewController
            let cell = sender as? UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell!)
            targetController.list = table[(indexPath?.row)!]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        table.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllListItem", for: indexPath)
        configureNameFor(cell: cell, withItem: table[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func configureNameFor(cell: UITableViewCell, withItem item: Checklist){
        
        cell.textLabel?.text = item.name
        
    }
}
