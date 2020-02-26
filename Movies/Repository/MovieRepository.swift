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
    
    /// It gets the list of movie for the especific page.
    /// - Parameters:
    ///   - page: page number
    ///   - completionHandler: <#completionHandler description#>
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
    
    /// It gets details of an especific movie.
    /// - Parameters:
    ///   - Id: movie id
    ///   - completionHandler: <#completionHandler description#>
    func getMovieDetail(movie Id: String, completionHandler: @escaping (_ movieDetail: [String:Any]?, _ error: [String:String]?) -> Void){
        if var urlComponents = URLComponents(string: baseUrl + "movie/\(Id)") {
            urlComponents.queryItems = [URLQueryItem(name: "api_key", value: TmdbApiKey), URLQueryItem(name: "language", value: "pt-BR")]
        guard let url = urlComponents.url
            else { return }
            
            dataTask?.cancel()
            dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
                data, response, error in
                if let _error = error{
                    return completionHandler(nil, ["error": _error.localizedDescription])
                }
                if let _data = data{
                    do {
                        if let movieDetailJson = try JSONSerialization.jsonObject(with: _data, options: []) as? [String:Any]{
                            completionHandler(movieDetailJson,nil)
                        }
                        else{
                            completionHandler(nil,["error": "Formato de dados não reconhecido"])
                        }
                    } catch{
                        completionHandler(nil, ["error": "Falha ao decodificar a resposta."])
                    }
                }
            })
            dataTask?.resume()
        }
    }
}
