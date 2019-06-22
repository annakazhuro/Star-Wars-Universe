//
//  SearchCharactersViewController.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 5/20/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import Foundation
import UIKit

class SearchCharacter: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var results: UITableView!
    
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        results.dataSource = self
        searchBar.delegate = self
        
    }
    
}

extension SearchCharacter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = results.dequeueReusableCell(withIdentifier: "searchResultCell")
        
        cell?.textLabel?.text = filteredData[indexPath.row]
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
    
}
