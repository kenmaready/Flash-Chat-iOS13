//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Ken Maready on 7/7/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var bubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var meIcon: UIImageView!
    
    @IBOutlet weak var youIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bubble.layer.cornerRadius = bubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
