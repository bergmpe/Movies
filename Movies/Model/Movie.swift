//
//  Movie.swift
//  Movies
//
//  Created by padrao on 21/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let id: Int?
    let adult: Bool?
    let backdrop_path: String?
    let poster_path: String?
    let overview: String?
    let genre_ids:[Int]?
    let original_language:String?
    let original_title:String?
    let popularity: Float?
    let release_date:String?
    let video: Bool?
    let title: String?
    let vote_average:Float?
    let vote_count:Int?
}
