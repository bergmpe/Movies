//
//  MovieImageRepository.swift
//  Movies
//
//  Created by padrao on 23/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import Foundation
import UIKit

class MovieImageRepository: Repository {
    
    let baseImageUrl = "http://image.tmdb.org/t/p/"
    let posterWidth = "w185"
    let backdropWidth = "w300"
    
    func getPosterImage(posterUrlString: String, completionHandler: @escaping (_ imageData: Data?) -> Void){
        
        guard let url = URL(string: baseImageUrl + posterWidth + posterUrlString)
            else { return completionHandler(Data(capacity: 200) )}
        
            let urlSession = URLSession.shared.dataTask(with: url, completionHandler: {
                data, response, error in
                if let _data = data{
                    do {
                        print(String(data: _data, encoding: String.Encoding.utf8))
                        //print(moviePage)
                        completionHandler(nil)
                    } catch let error as NSError {
                        print("Failed to load: \(error)")
                    }
                }
            })
            urlSession.resume()
        }
}
