//
//  MoviesListCell.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 6/21/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import UIKit

class MoviesListCell: UITableViewCell {

    // - UI
    @IBOutlet weak var movieCell: UIView!
    
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        // Initialization code
    }

}

extension MoviesListCell {

    func configure() {
        configureMovieCell()
    }

    func configureMovieCell() {
        movieCell.backgroundColor = UIColor.gray
    }

}
