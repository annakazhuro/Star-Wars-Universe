//
//  MoviesController.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 5/20/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import Foundation
import UIKit

class MoviesTableViewController: UIViewController {
   
    // - UI
    @IBOutlet weak var moviesList: UITableView!
    
    // - Manager
    fileprivate var dataSource: MoviesDataSource!
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.moviesList.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        configure()
    }
    
}

// MARK: - Data source delegate

extension MoviesTableViewController: MoviesDataSourceDelegate {
    
    func didTapOnCell(film: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Storyboard.movieInfo.rawValue) as! MovieInfoViewController
        vc.titleFromCell = film
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Configure

extension MoviesTableViewController {
    
    func configure() {
        configureDataSourceDelegate()
    }
    
    func configureDataSourceDelegate() {
        dataSource = MoviesDataSource(tableView: moviesList)
        dataSource.delegate = self
    }
    
}
