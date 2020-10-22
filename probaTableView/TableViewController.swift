//
//  TableViewController.swift
//  probaTableView
//
//  Created by Ujin Artuhovich on 5/9/20.
//  Copyright © 2020 Ujin Artuhovich. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var objects = [
        Emoji(emoji: "label", name: "label", descripation: "label", isFavourite: true),
        Emoji(emoji: "label", name: "label", descripation: "label", isFavourite: true),
        Emoji(emoji: "label", name: "label", descripation: "label", isFavourite: true)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Emoji Reader"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        let sourceVC = segue.source as! NewTableViewController
        let emoji = sourceVC.emoji
        
        if let selectedindexpath = tableView.indexPathForSelectedRow {
            objects[selectedindexpath.row]  = emoji
            tableView.reloadRows(at: [selectedindexpath], with: .fade)
        }
            else {
                let newIndexPath = IndexPath(row: objects.count, section: 0)
                objects.append(emoji)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
            }
        }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji"else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        let navigation = segue.destination as! UINavigationController
        let newEmoji = navigation.topViewController as! NewTableViewController
        newEmoji.emoji = emoji
        newEmoji.title = "edit"
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]
        cell.set(object: object)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
      
    }
  
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
        
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let fav = favourAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, fav])
    }
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action , view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
    
        }
        action.backgroundColor = .systemRed
        action.image = UIImage(systemName: "trash")
            return action
            
        }
    func favourAction(at indexPath: IndexPath) -> UIContextualAction{
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Fav") {
            (action, view, completion) in
            object.isFavourite = !object.isFavourite
            self.objects[indexPath.row] = object
            completion(true)
        }
        action.backgroundColor = object.isFavourite ? .systemGray : .systemPink
        action.image = UIImage(systemName: "heart")
            return action
        }

    }
    

