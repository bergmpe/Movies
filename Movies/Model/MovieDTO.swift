//
//  MoviePage.swift
//  Movies
//
//  Created by padrao on 22/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import Foundation

struct MovieDTO:Codable {
    let total_pages: Int?
    let page: Int?
    let total_results:Int?
    let results:[Movie]?
}
