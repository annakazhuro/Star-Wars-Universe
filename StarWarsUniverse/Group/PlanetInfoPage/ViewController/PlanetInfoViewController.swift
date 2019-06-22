//
//  PlanetInfoViewController.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 6/2/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import UIKit
import RealmSwift

class PlanetInfoViewController: UIViewController {

    @IBOutlet weak var planetName: UILabel!
    @IBOutlet weak var planetPopulation: UILabel!
    @IBOutlet weak var planetClimate: UILabel!
    @IBOutlet weak var planetDiameter: UILabel!
    @IBOutlet weak var planetTerrain: UILabel!
    
    var urlOfPlanet = ""
    
    var planet: Results<Planet>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setDatabase()
        
    }
    
    func setDatabase() {
        
        self.showInfo()

    }

    func showInfo() {
        
        let realm = try! Realm()
        let predicate = NSPredicate(format: "url = %@", "\(urlOfPlanet)")
        let planetDB = realm.objects(Planet.self)
        
        if let planet = planetDB.filter(predicate).first {
            
            self.planetName.text = planet.name
            self.planetPopulation.text = "\(planet.population)"
            self.planetClimate.text = planet.climate
            self.planetDiameter.text = "\(planet.diameter)"
            self.planetTerrain.text = planet.terrain
            
        }
        
    }
    
}
