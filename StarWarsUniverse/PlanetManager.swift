//
//  PlanetManager.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 6/2/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//
import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON

class PlanetManager {
    
    //MARK: - API url
    
    func setPlanetData() {
        
        self.alamofireRequest(nextToken: "https://swapi.co/api/planets/")
        
    }
    
}

//MARK: - Configure Data

extension PlanetManager {
        
    func alamofireRequest(nextToken: String) {
        AF.request(nextToken, method: .get, parameters: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json["next"].exists() {
                    self.alamofireRequest(nextToken: (json["next"]).rawString()!)
                }
                self.updatePlanetList(json: json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updatePlanetList(json: JSON) {
        
        let results = json["results"].array
        for planet in results! {
            let realm = try! Realm()
            try! realm.write {
                let planetModel = Planet()
                
                planetModel.url = planet["url"].rawString() ?? ""
                planetModel.name = planet["name"].rawString() ?? ""
                planetModel.population = Int(planet["population"].rawString() ?? "0") ?? 0
                planetModel.climate = planet["climate"].rawString() ?? ""
                planetModel.diameter = Int(planet["diameter"].rawString() ?? "0") ?? 0
                planetModel.terrain = planet["terrain"].rawString() ?? ""
                
                realm.add(planetModel, update: true)
            }
        }
        
    }
    
}
