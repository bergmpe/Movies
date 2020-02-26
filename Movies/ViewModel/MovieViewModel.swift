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
    func didFinishFetchWithError(message: String)
    func didStartFetch()
}

class MovieViewModel {
    
    private var page = 1
    var delegate: MovieViewModelProtocol?
    
    func fetchMovies(){
        let repository = MovieRepository()
        delegate?.didStartFetch()
        repository.getMovies(page: String(page), completionHandler: {
            [weak self] movieDTO, errorDict in
            if let _movieDTO = movieDTO, let movies = _movieDTO.results{
                self?.page = (_movieDTO.page ?? self!.page) + 1
                self?.delegate?.didFinishFetch(with: movies)
            }
            else{
                if let _errorDict = errorDict, let statusMessage = _errorDict["status_message"]{
                    self?.delegate?.didFinishFetchWithError(message: statusMessage)
                }
                else{
                    self?.delegate?.didFinishFetchWithError(message: "Erro ao obter a lista de filmes. Verifique sua conexão com a internet.")
                }
            }
        })
    }
    
    func getPosterUrl(for movie: Movie) -> URL?{
        let repository = MovieRepository()
        return URL(string: repository.baseImageUrl + PosterSize.small.rawValue + (movie.poster_path ?? ""))
    }
    
}
