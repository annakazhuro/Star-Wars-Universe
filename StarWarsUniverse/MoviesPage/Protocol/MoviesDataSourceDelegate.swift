//
//  MoviesDelegate.swift
//  StarWarsUniverse
//
//  Created by Anna Kazhuro on 6/20/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesDataSourceDelegate: class {
    
    func didTapOnCell(film: String)
    
}
