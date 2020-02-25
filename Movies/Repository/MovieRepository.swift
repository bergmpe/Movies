//
//  MovieRepository.swift
//  Movies
//
//  Created by padrao on 21/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import Foundation
import UIKit


class MovieRepository: Repository{
        
    weak var dataTask: URLSessionDataTask?
    
    func getMovies(page: String, completionHandler: @escaping (_ moviePage: MovieDTO?, _ error: [String:String]?) -> Void){
        if var urlComponents = URLComponents(string: baseUrl + "discover/movie") {
            urlComponents.queryItems = [URLQueryItem(name: "api_key", value: TmdbApiKey), URLQueryItem(name: "language", value: "pt-BR"), URLQueryItem(name: "page", value: page)]
        guard let url = urlComponents.url
            else { return }
            
            dataTask?.cancel()
            dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
                data, response, error in
                if let _error = error{
                    return completionHandler(nil, ["erro": _error.localizedDescription])
                }
                if let _data = data{
                    do {
                        let moviePage = try JSONDecoder().decode( MovieDTO.self, from: _data)
                        completionHandler(moviePage,nil)
                    } catch{
                        completionHandler(nil, ["erro": "Falha ao decodificar a resposta."])
                    }
                }
            })
            dataTask?.resume()
        }
    }
}
