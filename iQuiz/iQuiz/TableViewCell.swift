//
//  TableViewCell.swift
//  iQuiz
//
//  Created by Anni Yan on 2/21/19.
//  Copyright © 2019 Anni Yan. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var descLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
