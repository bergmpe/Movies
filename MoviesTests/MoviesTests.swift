//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by padrao on 21/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDetailMovieViewModelPostUrl() {
        let movie = Movie(id: nil, adult: nil, backdrop_path: nil, poster_path: nil, overview: nil, genre_ids: nil, original_language: nil, original_title: nil, popularity: nil, release_date: nil, video: nil, title: nil, vote_average: 6.8, vote_count: 30)
        let repository = MovieRepository()
        let detailViewModel = DetailMovieViewModel(movie: movie)
        
        XCTAssertEqual(detailViewModel.posterUrl(), URL(string:repository.baseImageUrl + PosterSize.small.rawValue + (movie.poster_path ?? "")))
    }

    func testDetailMovieViewModelBackdropPathUrl() {
        let movie = Movie(id: nil, adult: nil, backdrop_path: nil, poster_path: nil, overview: nil, genre_ids: nil, original_language: nil, original_title: nil, popularity: nil, release_date: nil, video: nil, title: nil, vote_average: 6.8, vote_count: 30)
        let repository = MovieRepository()
        let detailViewModel = DetailMovieViewModel(movie: movie)
        
        XCTAssertEqual(detailViewModel.backdropPathUrl(), URL(string: repository.baseImageUrl + BackdropSize.small.rawValue + (movie.backdrop_path ?? "")))
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
