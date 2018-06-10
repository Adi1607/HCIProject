//
//  JobApplicationTableViewCell.swift
//  JobTracker
//
//  Created by Pallavi Patil on 4/15/18.
//  Copyright © 2018 Pallavi Patil. All rights reserved.
//

import UIKit

class JobApplicationTableViewCell: UITableViewCell {
    
    //MARK: Properties

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
