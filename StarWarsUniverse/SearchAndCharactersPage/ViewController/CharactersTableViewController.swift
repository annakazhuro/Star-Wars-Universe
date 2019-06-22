//
//  CharactersTableViewController.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 5/27/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift

class CharactersTableViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var charactersList: UITableView!
    
    var filteredData: [String]!
    let characterManager = CharacterManager()
    let speciesManager = SpeciesManager()
    var person: Results<Character>?
    var data = [String]()
    
    // MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        self.setDatabase()
    }
    
    func setDatabase() {
        characterManager.setCharacterData()
        speciesManager.setSpeciesData()
        self.showCharactersList()
    }
        
    func showCharactersList() {
        
        let realm = try! Realm()
        self.person = realm.objects(Character.self)
        self.charactersList.reloadData()
        
        for item in person! {
            
            let element = item.name
            data.append(element)
            
        }
        
        var k = 0
        for item in data {
            k = k + 1
            print("\(k) - \(item)")
        }
        
        filteredData = data
        self.charactersList.delegate = self
        self.charactersList.dataSource = self
        self.charactersList.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellID)
        
    }
}

extension CharactersTableViewController: UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return Constants.sectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = self.charactersList.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
        cell.backgroundColor = UIColor.gray
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.searchBar.resignFirstResponder()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Storyboard.characterInfo.rawValue) as! CharacterInfoViewController
        
        vc.characterIndex = indexPath.row
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)!
        
        let celltext = currentCell.textLabel!.text
        vc.name = celltext!
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        self.charactersList.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    enum Constants {
        static let cellID = "characterCell"
        static let sectionsCount = 1
    }
}
