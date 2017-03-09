//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by iem on 09/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController {
    
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    var delegate: ListDetailViewControllerDelegate?
    
    var from: String?
    
    var editIndex: Int?
    
    var editList: Checklist?
    
    var imageChosenName: String?

    
    @IBAction func cancel() {
        
        delegate?.listDetailViewControllerDidCancel(controller: self)
        
    }
    
    @IBAction func textFieldChanged(_ sender: AnyObject) {
        let text: NSString = (textField.text as NSString?)!
        
        if text.length > 0 {
            doneBarButton.isEnabled = true
        } else {
            doneBarButton.isEnabled = false
        }
        
    }
    
    @IBAction func done() {
        print(textField.text)
        if(from == "Add"){
            let item = Checklist(name: textField.text!)
            delegate?.addListViewController(controller: self, didFinishAddingItem: item)
        }else if(from == "Edit"){
            let item = Checklist(name: textField.text!)
            delegate?.editListViewController(controller: self, item: item, index: editIndex!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
        if(imageChosenName != nil){
            var image: UIImage
            image = UIImage(named: imageChosenName!)!
            imageView.image = image
        }
        
        if(from == "Edit"){
            self.title = "Edit list"
            textField.text = editList?.name
            doneBarButton.isEnabled = true
        }
    }
    
    
}

protocol ListDetailViewControllerDelegate : class {
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)
    func addListViewController(controller: ListDetailViewController, didFinishAddingItem item: Checklist)
    func editListViewController(controller: ListDetailViewController, item: Checklist, index: Int)
    
} 
