//
//  ViewController.swift
//  Movies
//
//  Created by padrao on 21/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, MovieViewModelProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let movieViewModel = MovieViewModel()
    var movies = [Movie](){
        didSet{
            DispatchQueue.main.async {
                self.colletionView.reloadData()
            }
        }
    }
    
    lazy var flowLayout: UICollectionViewFlowLayout = { [weak self] in
        let _flowLayout = UICollectionViewFlowLayout()
        let width = ((self?.view.bounds.width ?? 200) / 2) - 6
        _flowLayout.itemSize = CGSize(width: width, height: width * 1.5)
        _flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
        _flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        _flowLayout.minimumInteritemSpacing = 0.0
        return _flowLayout
    }()
    
    lazy var colletionView: UICollectionView = { [weak self] in
        guard let me = self else { return UICollectionView() }
        let obj = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: me.flowLayout)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .clear
        return obj
    }()
    
//    lazy var refreshControle: UIRefreshControl = { [weak self] in
//        guard let me = self else { return UIRefreshControl() }
//        let obj = UIRefreshControl()
//        obj.addTarget(me, action: #selector(me.refreshData), for: .valueChanged)
//        return obj
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupColletioView()
        setupNavBar()
        movieViewModel.delegate = self
        movieViewModel.fetchMovies()
        
//        let service = MovieRepository()
//        service.getMovies()
    }
    
    func setupColletioView() {
        //self.colletionView.addSubview(self.refreshControle)
        self.colletionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "CatalogoCollectionViewCell")
        self.colletionView.delegate = self
        self.colletionView.dataSource = self
        self.view.addSubview(self.colletionView)
        self.colletionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 2).isActive = true
        self.colletionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -2).isActive = true
        self.colletionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.colletionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    }
    
    func setupNavBar(){
        self.navigationItem.title = "Movies"
    }
    
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatalogoCollectionViewCell", for: indexPath) as? MovieCollectionViewCell {
            let url = URL(string: "https://image.tmdb.org/t/p/" + "w185" + (movies[indexPath.row].poster_path ?? ""))
            cell.movieImageView.load(url: url!)
            cell.config(movie: movies[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
    }
    
    //MARK: MovieViewModelProtocol
    func didFinishFetch(with movies: [Movie]) {
        print(movies)
        self.movies = movies
    }


}

