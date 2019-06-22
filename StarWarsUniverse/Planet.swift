//
//  Planet.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 6/2/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import Foundation
import RealmSwift

class Planet: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var population = 0
    @objc dynamic var climate = ""
    @objc dynamic var diameter = 0
    @objc dynamic var terrain = ""
    @objc dynamic var url = ""
    
    override static func primaryKey() -> String? {
        return "url"
    }
    
}
