//
//  ViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var table = [ChecklistItem(text: "test1"),ChecklistItem(text: "test2"),ChecklistItem(text: "test3"),ChecklistItem(text: "test4"),ChecklistItem(text: "test5", checked: true),ChecklistItem(text: "test6")]
    
    var editItem: ChecklistItem?
    
    var list: Checklist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = list.name
        tableView.delegate = self
        tableView.dataSource = self
        table = list.items
//        loadChecklistItems()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var button: UIBarButtonItem!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddItem" ){
            let destinationNavigationController = segue.destination as? UINavigationController
            let targetController = destinationNavigationController?.topViewController as! AddItemViewController
            targetController.delegate = self
            targetController.from = "Add"
        }else if(segue.identifier == "EditItem" ){
            let destinationNavigationController = segue.destination as? UINavigationController
            let targetController = destinationNavigationController?.topViewController as! AddItemViewController
            let cell = sender as? UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell!)
            targetController.delegate = self
            targetController.from = "Edit"
            targetController.editIndex = indexPath?.row
            editItem = table[(indexPath?.row)!]
            targetController.editItem = self.editItem
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        table.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
//        saveChecklistItems()
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureTextFor(cell: cell, withItem: table[indexPath.row])
        configureCheckmarkFor(cell: cell, withItem: table[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        table[indexPath.row].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
//        saveChecklistItems()
    }

    func configureCheckmarkFor(cell: UITableViewCell, withItem item: ChecklistItem){
        if(item.checked){
            let label = cell.viewWithTag(1) as! UILabel
            label.isHidden = false
        }else{
            let label = cell.viewWithTag(1) as! UILabel
            label.isHidden = true
        }
    }
    
    func configureTextFor(cell: UITableViewCell, withItem item: ChecklistItem){
        let label = cell.viewWithTag(2) as! UILabel
        label.text = item.text
    }
    
//    func documentDirectory() -> URL{
//        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
//        let urlPath = URL(string: path)
//        return urlPath!
//        
//    }
//    
//    func dataFileUrl() -> URL{
//        let documentDirectory = self.documentDirectory()
//        let path = documentDirectory.appendingPathComponent("/checklists.plist")
//        return path
//    }
//    
//    
//    
//    func saveChecklistItems(){
//        
//        NSKeyedArchiver.archiveRootObject(_: table, toFile: dataFileUrl().absoluteString)
//            
//    }
//    
//    func loadChecklistItems(){
//        table = NSKeyedUnarchiver.unarchiveObject(withFile: dataFileUrl().absoluteString) as! [ChecklistItem]
//    }

}

//MARK: - AddItemViewControllerDelegate
extension ChecklistViewController: AddItemViewControllerDelegate {
    func addItemViewControllerDidCancel(controller: AddItemViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem){
        dismiss(animated: true, completion: nil)
        table.append(item)
        let indexPath = IndexPath(row: table.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
//        saveChecklistItems()
    }
    
    func editItemViewController(controller: AddItemViewController, item: ChecklistItem, index: Int) {
        dismiss(animated: true, completion: nil)
        table[index] = item
        tableView.reloadData()
//        saveChecklistItems()
    }
}




