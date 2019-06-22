//
//  MoviesTableViewCell.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 5/23/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
