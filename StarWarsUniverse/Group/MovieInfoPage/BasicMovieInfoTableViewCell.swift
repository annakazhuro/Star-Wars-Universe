//
//  BasicMovieInfoTableViewCell.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 6/18/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import UIKit

class BasicMovieInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
