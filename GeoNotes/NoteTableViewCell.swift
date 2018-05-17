//
//  NoteTableViewCell.swift
//  GeoNotes
//
//  Created by Andrius Kelly on 5/17/18.
//  Copyright © 2018 Andrius Kelly. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
 

    @IBOutlet weak var noteTextLabel: UILabel!
    @IBOutlet weak var noteLocationLabel: UILabel!
    
    
}
