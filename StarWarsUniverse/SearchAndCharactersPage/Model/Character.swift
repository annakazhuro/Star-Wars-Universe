//
//  Character.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 5/25/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import Foundation
import RealmSwift

class Character: Object {
    @objc dynamic var name = ""
    @objc dynamic var height = 0
    @objc dynamic var birthYear = ""
    @objc dynamic var gender = ""
    @objc dynamic var homeworld = ""
    @objc dynamic var created = ""
    @objc dynamic var url = ""
    var films = List<String>()
    var species = List<String>()
    var vehicles = List<String>()
    var starships = List<String>()
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
