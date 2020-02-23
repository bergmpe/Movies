//
//  MovieViewModel.swift
//  Movies
//
//  Created by padrao on 22/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import Foundation

protocol MovieViewModelProtocol {
    func didFinishFetch(with movies: [Movie])
}

class MovieViewModel {
    
    private var page = 1
    var delegate: MovieViewModelProtocol?
    
    func fetchMovies(){
        let repository = MovieRepository()
        repository.getMovies(completionHandler: {
            movieDTO, errorDict in
            if let movies = movieDTO?.results{
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
}
