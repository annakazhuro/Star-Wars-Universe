//
//  Species.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 6/4/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import Foundation
import RealmSwift

class Species: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var url = ""
    
    override static func primaryKey() -> String? {
        return "url"
    }
    
}
