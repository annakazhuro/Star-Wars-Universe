//
//  Movie.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 5/23/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//
import Foundation
import RealmSwift

class Movie: Object {
    @objc dynamic var title = ""
    @objc dynamic var episodeID = 0
    @objc dynamic var releaseDate = ""
    @objc dynamic var director = ""
    @objc dynamic var crawl = ""
    @objc dynamic var url = ""
    var characters = List<String>()
    
    override static func primaryKey() -> String? {
        return "url"
    }
}
