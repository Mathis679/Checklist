//
//  AllListViewController.swift
//  Checklists
//
//  Created by iem on 09/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Checklists"
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SeeList"){
            let targetController = segue.destination as! ChecklistViewController
            let cell = sender as? UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell!)
            targetController.list = DataModel.sharedInstance.table[(indexPath?.row)!]
        }else if (segue.identifier == "AddList" ){
            let destinationNavigationController = segue.destination as? UINavigationController
            let targetController = destinationNavigationController?.topViewController as! ListDetailViewController
            targetController.delegate = self
            targetController.from = "Add"
        }else if(segue.identifier == "EditList" ){
            let destinationNavigationController = segue.destination as? UINavigationController
            let targetController = destinationNavigationController?.topViewController as! ListDetailViewController
            let cell = sender as? UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell!)
            targetController.delegate = self
            targetController.from = "Edit"
            targetController.editIndex = indexPath?.row
            targetController.editList = DataModel.sharedInstance.table[(indexPath?.row)!]
        }

            
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.sharedInstance.table.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        DataModel.sharedInstance.table.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllListItem", for: indexPath)
        configureNameFor(cell: cell, withItem: DataModel.sharedInstance.table[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func configureNameFor(cell: UITableViewCell, withItem item: Checklist){
        var detailText: String
        cell.textLabel?.text = item.name
        if(item.items.count == 0){
            detailText = "(No item)"
        }else if(item.countChecked() == item.items.count){
            detailText = "All done!!"
        }else{
            detailText = "\(item.countChecked())"+"/"+"\(item.items.count)"

        }
        cell.detailTextLabel?.text = detailText
        
    }
    
    

}



//MARK: - ListDetailViewControllerDelegate
extension AllListViewController: ListDetailViewControllerDelegate {
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func addListViewController(controller: ListDetailViewController, didFinishAddingItem item: Checklist){
        dismiss(animated: true, completion: nil)
        DataModel.sharedInstance.table.append(item)
        let indexPath = IndexPath(row: DataModel.sharedInstance.table.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    func editListViewController(controller: ListDetailViewController, item: Checklist, index: Int) {
        dismiss(animated: true, completion: nil)
        DataModel.sharedInstance.table[index] = item
        tableView.reloadData()
    }
}


