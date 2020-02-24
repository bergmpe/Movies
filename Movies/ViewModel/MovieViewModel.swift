//
//  MovieViewModel.swift
//  Movies
//
//  Created by padrao on 22/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import Foundation
import UIKit

protocol MovieViewModelProtocol {
    func didFinishFetch(with movies: [Movie])
}

class MovieViewModel {
    
    private var page = 1
    var delegate: MovieViewModelProtocol?
    
    func fetchMovies(){
        let repository = MovieRepository()
        repository.getMovies(page: String(page), completionHandler: {
            movieDTO, errorDict in
            if let _movieDTO = movieDTO, let movies = _movieDTO.results{
                self.page = (_movieDTO.page ?? self.page) + 1
                self.delegate?.didFinishFetch(with: movies)
            }
            else{
                if let _errorDict = errorDict, let statusMessage = _errorDict["status_message"] as? String{
                    //completionHandler([],statusMessage)
                }
                else{
                    //completionHandler([],"Error ao obter a lista de filmes. Verifique sua conexão com a internet.")
                }
            }
        })
    }
    
    func getPosterUrl(for movie: Movie) -> URL?{
        let repository = MovieRepository()
        return URL(string: repository.baseImageUrl + PosterSize.small.rawValue + (movie.poster_path ?? ""))
    }
    
}
