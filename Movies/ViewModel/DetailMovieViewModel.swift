//
//  DetailMovieViewModel.swift
//  Movies
//
//  Created by padrao on 25/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import Foundation

protocol DetailMovieViewModelDelegate {
    func didFinishFetch()
    func didFinishFetchWithError(message: String)
    func didStartFetch()
}

class DetailMovieViewModel{
    
    private var movie: Movie
    var detailMovieDelegate: DetailMovieViewModelDelegate?
    
    var title = "-"
    var voteAverage = "-"
    var genres = "-"
    var overview = "-"
    var releaseYear = "-"
    var productionCompanies = "-"
    var vote = "-"
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func getPosterUrl() -> URL?{
        let repository = MovieRepository()
        return URL(string: repository.baseImageUrl + PosterSize.small.rawValue + (movie.poster_path ?? ""))
    }
    
    func getBackdropPathUrl() -> URL?{
        let repository = MovieRepository()
        return URL(string: repository.baseImageUrl + BackdropSize.small.rawValue + (movie.backdrop_path ?? ""))
    }
    
    func fetchDetail(){
        detailMovieDelegate?.didStartFetch()
        let repository = MovieRepository()
        if let id = movie.id{
            repository.getMovieDetail(movie: String(id), completionHandler: { [weak self] movieDetailDict, errorDict in
                
                if let _movieDetailDict = movieDetailDict{
                    self?.title = (_movieDetailDict["title"] as? String) ?? "-"
                    self?.overview = (_movieDetailDict["overview"] as? String) ?? "-"
                    
                    self?.genres = ( self?.getGenresNames( from: _movieDetailDict["genres"] as! [[String : Any]]) ?? "Gênero: -")
                    self?.releaseYear = self?.getReleaseYear(from: _movieDetailDict["release_date"] as? String) ?? "Ano de lançamento: -"
                    self?.productionCompanies = ( self?.getProductionCompanies( from: _movieDetailDict["production_companies"] as! [[String : Any]]) ?? "Produtora(s): -")
                    self?.vote = self?.getVote(from: _movieDetailDict) ?? "Nota: -"
                    self?.detailMovieDelegate?.didFinishFetch()
                }
                else{
                    if let error = errorDict{
                    self?.detailMovieDelegate?.didFinishFetchWithError(message: error["error"] ?? "Erro ao obter os detalhes do filmes. Verifique sua conexão com a internet.")
                    }
                    else{
                        self?.detailMovieDelegate?.didFinishFetchWithError(message: "Erro ao obter os detalhes do filmes. Verifique sua conexão com a internet.")
                    }
                }
            })
        
        }
        else{
            detailMovieDelegate?.didFinishFetchWithError(message: "Identificador do filme inválido.")
        }
    }
    
    private func getGenresNames(from dictionaryArray: [[String: Any]]) -> String{
        let genresArray = dictionaryArray.compactMap({$0["name"] as? String})
        return "Gênero: " + genresArray.joined(separator: ", ")
    }
    
    private func getReleaseYear(from releaseDate: String?) -> String{
        guard let _releaseDate = releaseDate else{
            return "Ano de lançamento: -"
        }
        return "Ano de lançamento: " + String(_releaseDate.split(separator: "-")[0])
    }
    
    private func getProductionCompanies(from dictionaryArray: [[String: Any]]) -> String{
        let productionCompaniesArray = dictionaryArray.compactMap({$0["name"] as? String})
        return "Produtora(s): " + productionCompaniesArray.joined(separator: ", ")
    }
    
    private func getVote(from dictionary: [String: Any]) -> String{
        var vote = ""
        if let voteAverage = dictionary["vote_average"] as? Double{
            let voteAverageTrucated = Int(voteAverage / 2)
            for _ in 1...voteAverageTrucated{
                vote += "⭐️ "
            }
            return "Nota: " + vote + "(\(voteAverage))"
        }
        else{
            return "Nota: -"
        }
    }
}
