//
//  SpeciesManagerViewController.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 6/4/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SpeciesManagerViewController: UIViewController {

    var url = ""
    
    func getSpecies() -> String {
        
        var name = ""
        
        AF.request(url, method: .get, parameters: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                name = json["name"].rawString()!
            case .failure(let error):
                print(error)
            }
        }
        
        return name
    }

}
