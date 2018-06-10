//
//  SearchResultTableViewCell.swift
//  JobTracker
//
//  Created by Pallavi Patil on 4/27/18.
//  Copyright © 2018 Pallavi Patil. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
