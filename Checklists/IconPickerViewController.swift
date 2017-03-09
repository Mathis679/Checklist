//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by iem on 09/03/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class IconPickerViewController: UITableViewController {

    var imageName: String = ""
    
    static let icons = [
        "Appointments",
        "Birthdays",
        "Chores",
        "Drinks",
        "Folder",
        "Groceries",
        "Inbox",
        "No Icon",
        "Photos",
        "Trips"]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Icon"
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "IconChosen"){
            
            let targetController = segue.destination as! ListDetailViewController
            
            targetController.imageChosenName = self.imageName
        }
    
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IconPickerViewController.icons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Icons", for: indexPath)
        cell.textLabel?.text = IconPickerViewController.icons[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        imageName = IconPickerViewController.icons[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
