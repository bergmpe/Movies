//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by padrao on 25/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, DetailMovieViewModelDelegate {
    
    var detailMovieViewModel: DetailMovieViewModel?
    let verticalMargin:CGFloat = 10
    let horizontalMargin:CGFloat = 5
    
    lazy var backdropMovieImageView: CachedUIImageView = {
        let obj = CachedUIImageView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFit
        obj.image = UIImage(named: "multimedia_placeholder")
        return obj
    }()
    
    lazy var scrollView: UIScrollView = {
        let obj = UIScrollView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var contentView: UIView = {
        let obj = UIView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var titleLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.textColor = .white
        obj.font = UIFont.boldSystemFont(ofSize: 25)
        obj.numberOfLines = 0
           return obj
    }()
    
    lazy var overviewLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.textColor = .white
        obj.textAlignment = .justified
        obj.numberOfLines = 0
           return obj
    }()
    
    lazy var genresLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.textColor = .white
        obj.numberOfLines = 0
           return obj
    }()
    
    lazy var releaseYearLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.textColor = .white
        return obj
    }()
    
    lazy var productionCompaniesLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.textColor = .white
        obj.numberOfLines = 0
        return obj
    }()
    
    lazy var voteLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.textColor = .white
        obj.text = "Nota: ⭐️\t número de votos: 682."
        obj.numberOfLines = 0
        return obj
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.setupSubViews()
        if let backdropUrl = detailMovieViewModel?.getBackdropPathUrl(){
            self.backdropMovieImageView.load(url: backdropUrl)
        }
        detailMovieViewModel?.detailMovieDelegate = self
        detailMovieViewModel?.fetchDetail()
    }
    
    func setupSubViews(){
        
        self.view.addSubview(backdropMovieImageView)
        self.backdropMovieImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.backdropMovieImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.backdropMovieImageView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        self.backdropMovieImageView.heightAnchor.constraint(equalToConstant: (self.view.frame.width) * 0.56).isActive = true
        
        self.view.addSubview(scrollView)
        self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: self.backdropMovieImageView.bottomAnchor, constant: 1).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        
        self.scrollView.addSubview(titleLabel)
        self.titleLabel.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 5).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: -5).isActive = true
        self.titleLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width - 10).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 10).isActive = true
        
        self.scrollView.addSubview(overviewLabel)
        self.overviewLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        self.overviewLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        self.overviewLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true

        self.scrollView.addSubview(genresLabel)
        self.genresLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        self.genresLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        self.genresLabel.topAnchor.constraint(equalTo: self.overviewLabel.bottomAnchor, constant: 10).isActive = true

        self.scrollView.addSubview(releaseYearLabel)
        self.releaseYearLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        self.releaseYearLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        self.releaseYearLabel.topAnchor.constraint(equalTo: self.genresLabel.bottomAnchor, constant: 10).isActive = true

        self.scrollView.addSubview(productionCompaniesLabel)
        self.productionCompaniesLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        self.productionCompaniesLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        self.productionCompaniesLabel.topAnchor.constraint(equalTo: self.releaseYearLabel.bottomAnchor, constant: 10).isActive = true

        self.scrollView.addSubview(voteLabel)
        self.voteLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        self.voteLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        self.voteLabel.topAnchor.constraint(equalTo: self.productionCompaniesLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        var scrollViewContentHeight:CGFloat = 0.0
        self.scrollView.subviews.forEach({
            subview in
            scrollViewContentHeight += subview.frame.size.height + verticalMargin
        })
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: scrollViewContentHeight)
    }
    
    func didFinishFetch() {
        DispatchQueue.main.async {
            self.titleLabel.text = self.detailMovieViewModel?.title
            self.overviewLabel.text = self.detailMovieViewModel?.overview
            self.genresLabel.text =  self.detailMovieViewModel?.genres
            self.releaseYearLabel.text = self.detailMovieViewModel?.releaseYear
            self.productionCompaniesLabel.text = self.detailMovieViewModel?.productionCompanies
            self.voteLabel.text = self.detailMovieViewModel?.vote
            self.scrollView.layoutIfNeeded()
        }
    }
    
    func didFinishFetchWithError(message: String) {
        
    }
    
    func didStartFetch() {
        
    }

}
