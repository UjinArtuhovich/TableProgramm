//
//  NewTableViewController.swift
//  probaTableView
//
//  Created by Ujin Artuhovich on 5/19/20.
//  Copyright © 2020 Ujin Artuhovich. All rights reserved.
//

import UIKit

class NewTableViewController: UITableViewController {
    var emoji = Emoji(emoji: " ", name: " ", descripation: " ", isFavourite: true)
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        saveButton.isEnabled = false
    }
    
    private func updateSave() {
        let emojiText = emojiTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty
        
    }
    private func updateUI() {
        emojiTextField.text = emoji.emoji
        nameTextField.text = emoji.name
        descriptionTextField.text = emoji.descripation
        
    }
    @IBAction func textChange(_ sender: UITextField) {
        
        updateSave()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        let emoji = emojiTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        self.emoji = Emoji(emoji: emoji , name: name , descripation: description, isFavourite: true)
    }
}
