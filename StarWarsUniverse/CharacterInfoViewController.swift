//
//  CharacterInfoViewController.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 6/1/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//


import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON

class CharacterInfoViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterGender: UILabel!
    @IBOutlet weak var characterBirthYear: UILabel!
    @IBOutlet weak var characterSpecies: UILabel!
    @IBOutlet weak var characterHomeworld: UIButton!
    @IBOutlet weak var characterRelatedMovies: UITableView!
    
    let speciesManager = SpeciesManager()
    let characterManager = CharacterManager()
    let planetManager = PlanetManager()
    var character: Results<Character>?
    var movies: Results<Movie>?
    var species = Species()
    
    var characterIndex = 0
    var name = ""
    var homeworldURL = ""
    var speciesURL = ""
    var relatedMovies = [String]()
    var titlesOfMovies = [String]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.characterRelatedMovies.delegate = self
        self.characterRelatedMovies.dataSource = self
        self.characterRelatedMovies.register(UITableViewCell.self, forCellReuseIdentifier: "relatedMovieCell")
        
        self.setInfo()

    }
    
    func setInfo() {
        
        self.planetManager.setPlanetData()
        
        let realm = try! Realm()
        self.movies = realm.objects(Movie.self)
        self.character = realm.objects(Character.self)
        
        let predicate = NSPredicate(format: "name = %@", "\(name)")
        if let person = realm.objects(Character.self).filter(predicate).first {
            self.configureUI(person: person)
        } else {
            self.setDefaultValues()
        }
        
    }

}

//MARK: - Configure

extension CharacterInfoViewController {
    
    func configureUI(person: Character?) {
        
        self.characterName.text = person?.name
        self.characterGender.text = person?.gender
        self.characterBirthYear.text = person?.birthYear

        self.configureSpeciesInfo(for: person)
        self.configureHomeworldInfo(for: person)
        self.configureRelatedMoviesInfo(for: person)
        
    }
    
    func configureSpeciesInfo(for person: Character?) {
        
        if let url = person?.species.first {
            self.speciesURL = url
        } else {
            self.speciesURL = ""
        }
        
        let realm = try! Realm()
        let predicate = NSPredicate(format: "url = %@", "\(speciesURL)")
        let speciesDB = realm.objects(Species.self)
        if let species = speciesDB.filter(predicate).first {
            let speciesName = species.name
            self.characterSpecies.text = speciesName
        } else {
            self.characterSpecies.text = "No info in DB"
        }
        
    }
    
    func configureHomeworldInfo(for person: Character?) {
        
        if let url = person?.homeworld {
             self.homeworldURL = url
        } else {
             self.homeworldURL = ""
        }
        
        let realm = try! Realm()
        let predicate = NSPredicate(format: "url = %@", "\(homeworldURL)")
        
        let planetDB = realm.objects(Planet.self)
        if let planet = planetDB.filter(predicate).first {
            let planetName = planet.name
            self.characterHomeworld.setTitle(planetName, for: .normal)
        } else {
            self.characterHomeworld.setTitle("NO INFO IN BD", for: .normal)
        }
        
        self.characterHomeworld.addTarget(self, action: #selector(CharacterInfoViewController.buttonClicked(sender:)), for: .touchUpInside)
        
    }
    
    func configureRelatedMoviesInfo(for person: Character?) {
        
        if let characterFilms = person?.films {
            self.relatedMovies = Array(characterFilms)
        } else {
            self.relatedMovies = []
        }
        
        for url in relatedMovies {
            
            let predicate = NSPredicate(format: "url = %@", "\(url)")
            if let film = movies?.filter(predicate).first {
                self.titlesOfMovies.append(film.title)
            } else {
                self.titlesOfMovies.append("No info in DB")
            }
        }
        
    }
    
    func setDefaultValues() {
        
        characterName.text = "No Info"
        characterGender.text = "No Info"
        characterBirthYear.text = "No Info"
        characterSpecies.text = "No Info"
        characterHomeworld.setTitle("No Info", for: .normal)
        
    }
    
}

//MARK: - Button action

extension CharacterInfoViewController {
    
    @objc func buttonClicked(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PlanetInfoViewController") as! PlanetInfoViewController
        vc.urlOfPlanet = homeworldURL
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension CharacterInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.relatedMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = self.characterRelatedMovies.dequeueReusableCell(withIdentifier: "relatedMovieCell", for: indexPath)
        
        let character = self.titlesOfMovies[indexPath.row]
        cell.backgroundColor = UIColor.gray
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = character
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieInfoViewController") as! MovieInfoViewController
        
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)!
        let celltext = currentCell.textLabel!.text
        vc.titleFromCell = celltext!
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    


}
