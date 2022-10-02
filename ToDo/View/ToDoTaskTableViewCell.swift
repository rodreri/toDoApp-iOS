//
//  ToDoTaskTableViewCell.swift
//  ToDo
//
//  Created by Rafael González on 19/09/22.
//

import UIKit

class ToDoTaskTableViewCell: UITableViewCell {

    
    @IBOutlet var taskTitleLabel: UILabel!
    var taskUUID : String?
    var taskTitle : String?
    var taskDate : Date?
    var tasknotes : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
