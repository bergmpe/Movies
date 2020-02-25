//
//  MovieViewController.swift
//  Movies
//
//  Created by padrao on 21/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import UIKit
import Lottie

class MovieViewController: UIViewController, MovieViewModelProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let movieViewModel = MovieViewModel()
    var movies = [Movie](){
        didSet{
            DispatchQueue.main.async {
                self.colletionView.reloadData()
            }
        }
    }
    var isFetchingData = false
    
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
    
    lazy var animationView: AnimationView = {
        let obj = AnimationView()
        let animation = Animation.named("loading")
        obj.animation = animation
        obj.loopMode = .loop
        obj.contentMode = .scaleAspectFit
        return obj
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColletioView()
        setupAnimationView()
        setupNavBar()
        movieViewModel.delegate = self
        movieViewModel.fetchMovies()
    }
    
    func setupColletioView() {
        self.colletionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        self.colletionView.delegate = self
        self.colletionView.dataSource = self
        self.view.addSubview(self.colletionView)
        self.colletionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 2).isActive = true
        self.colletionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -2).isActive = true
        self.colletionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.colletionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    }
    
    func setupAnimationView(){
        self.view.addSubview(animationView)
        self.animationView.translatesAutoresizingMaskIntoConstraints = false
        self.animationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.animationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.animationView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.animationView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setupNavBar(){
        self.navigationItem.title = "Movies"
    }
    
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell {
            cell.movieImageView.image = UIImage(named: "multimedia_placeholder")
            if let posterUrl = movieViewModel.getPosterUrl(for: movies[indexPath.row]){
                cell.movieImageView.load(url: posterUrl)
                    return cell
                }
            }
            return UICollectionViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        let reload_distance: CGFloat = 5.0

        if (y > (h + reload_distance)) && self.movies.count > 0 && !isFetchingData{
            isFetchingData = true
            movieViewModel.fetchMovies()
        }
    }

    //MARK: MovieViewModelProtocol
    func didStartFetch() {
        self.animationView.play()
    }
    
    func didFinishFetch(with movies: [Movie]) {
        isFetchingData = false
        self.movies.append(contentsOf: movies)
        DispatchQueue.main.async {
            self.animationView.stop()
        }
    }
    
    func didFinishFetchWithError(message: String) {
        DispatchQueue.main.async {
            self.animationView.stop()
            let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }


}

