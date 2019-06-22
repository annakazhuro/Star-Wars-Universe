//
//  SpeciesManager.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 6/4/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class SpeciesManager {
    
    func setSpeciesData() {
        
        self.alamofireRequest(nextToken: "https://swapi.co/api/species/")
        
    }
    
}

//MARK: - Configure Data

extension SpeciesManager {
    
    func alamofireRequest(nextToken: String) {
        
        AF.request(nextToken, method: .get, parameters: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json["next"].exists() {
                    self.alamofireRequest(nextToken: (json["next"]).rawString()!)
                }
                self.updateSpeciesList(json: json)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func updateSpeciesList(json: JSON) {
        
        let results = json["results"].array
        for species in results! {
            let realm = try! Realm()
            try! realm.write {
                let speciesModel = Species()
                
                speciesModel.name = species["name"].rawString() ?? ""
                speciesModel.url = species["url"].rawString() ?? ""
                
                realm.add(speciesModel, update: true)
            }
        }
        
    }
    
}
