//
//  GroupReviewTableViewCell.swift
//  together
//
//  Created by ooo on 01/08/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit

class GroupReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reViewTextView: UITextView!
    @IBOutlet weak var loginUser: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
