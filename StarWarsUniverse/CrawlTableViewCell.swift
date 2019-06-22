//
//  CrawlTableViewCell.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 6/18/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import UIKit

class CrawlTableViewCell: UITableViewCell {

    @IBOutlet weak var movieCrawl: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInfo(value: String) {
        
       // self.movieCrawl.text = value
        
    }

}
