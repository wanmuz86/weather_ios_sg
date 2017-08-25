//
//  CustomTableViewCell.swift
//  Weather App
//
//  Created by wan muzaffar Wan Hashim on 25/08/2017.
//  Copyright © 2017 iTrain Asia Pte Ltd. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet var tempLbl: UILabel!
    @IBOutlet var weatherLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!

    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var weatherDescLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
