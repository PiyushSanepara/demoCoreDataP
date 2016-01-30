//
//  DetailTableViewCell.swift
//  DemoCoreData
//
//  Created by Ratnakala21 on 1/23/16.
//  Copyright © 2016 Ratnakala21. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell
{
    @IBOutlet weak var lbl_name: UILabel!
    
    @IBOutlet weak var lbl_contact: UILabel!
    
    @IBOutlet weak var lbl_standard: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
