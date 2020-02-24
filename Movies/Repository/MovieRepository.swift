//
//  Service.swift
//  Movies
//
//  Created by padrao on 21/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import Foundation


class MovieRepository: Repository{
    
    func getMovies(page: String, completionHandler: @escaping (_ moviePage: MovieDTO?, _ error: [String:AnyObject]?) -> Void){
        if var urlComponents = URLComponents(string: baseUrl + "discover/movie") {
            urlComponents.queryItems = [URLQueryItem(name: "api_key", value: TmdbApiKey), URLQueryItem(name: "language", value: "pt-BR"), URLQueryItem(name: "page", value: page)]
        guard let url = urlComponents.url
            else { return }
        
            let urlSession = URLSession.shared.dataTask(with: url, completionHandler: {
                data, response, error in
                if let _data = data{
                    do {
                        let moviePage = try JSONDecoder().decode( MovieDTO.self, from: _data)
                        //print(moviePage)
                        completionHandler(moviePage,nil)
                    } catch let error as NSError {
                        print("Failed to load: \(error)")
                    }
                }
            })
            urlSession.resume()
        }
    }
}
