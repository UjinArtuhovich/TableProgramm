//
//  EmojiTableViewCell.swift
//  probaTableView
//
//  Created by Ujin Artuhovich on 5/9/20.
//  Copyright © 2020 Ujin Artuhovich. All rights reserved.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var EmojiLabel: UILabel!
      @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    func set(object: Emoji) {
        self.EmojiLabel.text = object.emoji
        self.nameLabel.text = object.name
        self.descriptionLabel.text = object.descripation
    
        
        
    }

}
