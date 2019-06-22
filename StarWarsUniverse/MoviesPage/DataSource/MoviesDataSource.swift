//
//  MoviesDataSource.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 6/18/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MoviesDataSource: NSObject {
    
    // - UI
    fileprivate unowned let tableView: UITableView

    // - Delegate
    weak var delegate: MoviesDataSourceDelegate?
    
    // -
    let movieManager = MovieManager()
    var movie: Results<Movie>?
    
    // - Lifecycle
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        configure()
    }
    
    func update() {
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource

extension MoviesDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return movie!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        return filmCell(indexPath: indexPath)
    }
    
}

// MARK: - UITableViewDelegate

extension MoviesDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)!
        let celltext = currentCell.textLabel!.text
        
        delegate?.didTapOnCell(film: celltext!)
        
    }

}

// MARK: - Cell

extension MoviesDataSource {
    
    func filmCell(indexPath: IndexPath) -> UITableViewCell{
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: Constant.movieTitleCell, for: indexPath) as! MoviesListCell
        let film = movie?[indexPath.row]
        cell.textLabel?.text = film?.title
        cell.textLabel?.textColor = .white
        
        return cell
        
    }
    
}

// MARK: - Configure

extension MoviesDataSource {
    
    func configure() {
        setUpDelegates()
        setUpDatabase()
    }
    
    func setUpDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUpDatabase() {
        movieManager.setMovieData()
        
        let realm = try! Realm()
        self.movie = realm.objects(Movie.self)
        
        if let number = movie?.count {
            Vars.numberOfMovies = number
        }
    }
    
}

// MARK: - Enums

extension MoviesDataSource {
    
    enum Vars {
        static var numberOfMovies = 0
    }
    enum Constant {
        static let movieTitleCell = "MoviesListCell"
    }
    
}
