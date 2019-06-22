//
//  CharacterManager.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 5/27/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON

class CharacterManager {
    
    //MARK: - API url
    func setCharacterData() {
        
        self.alamofireRequest(nextToken: "https://swapi.co/api/people/")
    
    }

}

//MARK: - Configure Data

extension CharacterManager {
    
    func alamofireRequest(nextToken: String) {
        AF.request(nextToken, method: .get, parameters: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json["next"].exists() {
                    self.alamofireRequest(nextToken: (json["next"]).rawString()!)
                }
                self.updateCharactersList(json: json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateCharactersList(json: JSON) {
        
        if let results = json["results"].array {
            for person in results {
                self.setDatabase(person: person)
            }
        } else {
            self.setDatabase(person: json)
        }
        
    }
    
    func setDatabase(person: JSON) {
        let realm = try! Realm()
        try! realm.write {
            
            let characterModel = Character()
            
            characterModel.name = person["name"].rawString() ?? "No"
            characterModel.height = Int(person["height"].rawString() ?? "0") ?? 0
            characterModel.birthYear = person["birth_year"].rawString() ?? "nil"
            characterModel.gender = person["gender"].rawString() ?? "no"
            characterModel.homeworld = person["homeworld"].rawString() ?? "no"
            characterModel.created = person["created"].rawString() ?? "nil"
            characterModel.url = person["url"].rawString() ?? "nil"
            
            let films = person["films"].array
            let species = person["species"].array
            let vehicles = person["vehicles"].array
            let starships = person["starships"].array
            characterModel.films = createList(array: films!)
            characterModel.species = createList(array: species!)
            characterModel.vehicles = createList(array: vehicles!)
            characterModel.starships = createList(array: starships!)
            
            realm.add(characterModel, update: true)
            
        }
        
    }
    
    func createList(array: [JSON]) -> List<String> {
        
        let list = List<String>()
        for record in array {
            list.append(record.rawString()!)
        }
        return list
        
    }
    
}
