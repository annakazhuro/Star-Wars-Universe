//
//  MovieManager.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 5/25/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON

class MovieManager {
    
    //MARK: - API url
    let url = "https://swapi.co/api/films/"
    
    func setMovieData() {
        
        self.alamofireRequest()
    
    }
    
    
}

//MARK: - Configure Data

extension MovieManager {
    
    func alamofireRequest() {
        
        AF.request(url, method: .get, parameters: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.updateMoviesList(json: json)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func updateMoviesList(json: JSON) {
        
        let results = json["results"].array
        for film in results! {
            let realm = try! Realm()
            try! realm.write {
                let movieModel = Movie()
                movieModel.url = film["url"].rawString()!
                movieModel.title = film["title"].rawString()!
                movieModel.director = film["director"].rawString()!
                movieModel.crawl = film["opening_crawl"].rawString()!
                movieModel.episodeID = Int(film["episode_id"].rawString()!)!
                movieModel.releaseDate = film["release_date"].rawString()!
                
                let characters = film["characters"].array
                let charactersList = List<String>()
                for record in characters! {
                    charactersList.append(record.rawString()!)
                }
                movieModel.characters = charactersList
                
                realm.add(movieModel, update: true)
            }
        }
        
    }
    
}
