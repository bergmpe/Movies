//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by padrao on 25/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import UIKit
import Lottie

class MovieDetailViewController: UIViewController, DetailMovieViewModelDelegate {
    
    var detailMovieViewModel: DetailMovieViewModel?
    let verticalMargin:CGFloat = 10
    let horizontalMargin:CGFloat = 5
    
    var animationViewHeightConstraint: NSLayoutConstraint?
    var animationViewWidthConstraint: NSLayoutConstraint?
    
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
        obj.numberOfLines = 0
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
       
       lazy var adviseLabel: UILabel = {
           let obj = UILabel()
           obj.text = "Falha ao carregar detalhes do filmes."
           obj.isHidden = true
           obj.textColor = .white
           return obj
       }()
       
       lazy var retryButton: UIButton = {
           [weak self] in
           let obj = UIButton()
           obj.setTitle("Tentar Novamente", for: .normal)
           obj.addTarget(self, action: #selector(self?.retryAction), for: .touchUpInside)
           obj.isHidden = true
           obj.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
           obj.layer.cornerRadius = 10
           obj.backgroundColor = .blue
           return obj
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.setupSubViews()
        self.getBackdropImage()
        self.detailMovieViewModel?.detailMovieDelegate = self
        self.detailMovieViewModel?.fetchDetail()
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
        self.titleLabel.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: horizontalMargin).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: -horizontalMargin).isActive = true
        self.titleLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width - verticalMargin).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: verticalMargin).isActive = true
        
        self.scrollView.addSubview(overviewLabel)
        self.overviewLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: horizontalMargin).isActive = true
        self.overviewLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -horizontalMargin).isActive = true
        self.overviewLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: verticalMargin).isActive = true

        self.scrollView.addSubview(genresLabel)
        self.genresLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: horizontalMargin).isActive = true
        self.genresLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -horizontalMargin).isActive = true
        self.genresLabel.topAnchor.constraint(equalTo: self.overviewLabel.bottomAnchor, constant: verticalMargin).isActive = true

        self.scrollView.addSubview(releaseYearLabel)
        self.releaseYearLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: horizontalMargin).isActive = true
        self.releaseYearLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -horizontalMargin).isActive = true
        self.releaseYearLabel.topAnchor.constraint(equalTo: self.genresLabel.bottomAnchor, constant: verticalMargin).isActive = true

        self.scrollView.addSubview(productionCompaniesLabel)
        self.productionCompaniesLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: horizontalMargin).isActive = true
        self.productionCompaniesLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -horizontalMargin).isActive = true
        self.productionCompaniesLabel.topAnchor.constraint(equalTo: self.releaseYearLabel.bottomAnchor, constant: verticalMargin).isActive = true

        self.scrollView.addSubview(voteLabel)
        self.voteLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: horizontalMargin).isActive = true
        self.voteLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -horizontalMargin).isActive = true
        self.voteLabel.topAnchor.constraint(equalTo: self.productionCompaniesLabel.bottomAnchor, constant: verticalMargin).isActive = true
        
        self.view.addSubview(adviseLabel)
        self.adviseLabel.translatesAutoresizingMaskIntoConstraints = false
        self.adviseLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.adviseLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.view.addSubview(animationView)
        self.animationView.translatesAutoresizingMaskIntoConstraints = false
        self.animationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.animationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.animationViewHeightConstraint =  self.animationView.heightAnchor.constraint(equalToConstant: 0)
        self.animationViewWidthConstraint =  self.animationView.widthAnchor.constraint(equalToConstant: 0)
        self.animationViewHeightConstraint?.isActive = true
        self.animationViewWidthConstraint?.isActive = true
        
        self.view.addSubview(retryButton)
        self.retryButton.translatesAutoresizingMaskIntoConstraints = false
        self.retryButton.topAnchor.constraint(equalTo: self.adviseLabel.bottomAnchor, constant: 20).isActive = true
        self.retryButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.retryButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        var scrollViewContentHeight:CGFloat = 0.0
        self.scrollView.subviews.forEach({
            subview in
            scrollViewContentHeight += subview.frame.size.height + verticalMargin
        })
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: scrollViewContentHeight)
    }
    
    @objc func retryAction(sender: UIButton){
        self.detailMovieViewModel?.fetchDetail()
        self.getBackdropImage()
    }
    
    func getBackdropImage(){
        if let backdropUrl = detailMovieViewModel?.getBackdropPathUrl(){
            self.backdropMovieImageView.load(url: backdropUrl)
        }
    }
    
    /// it shows the advice label and the retry button when fails get movies from server.
    func showAdviceView(){
        self.adviseLabel.isHidden = false
        self.retryButton.isHidden = false
    }
    
    func hideAdviceView(){
        self.adviseLabel.isHidden = true
        self.retryButton.isHidden = true
    }
    
    func showLoadingView(){
        self.animationViewHeightConstraint?.constant = 200
        self.animationViewWidthConstraint?.constant = 200
        self.view.layoutIfNeeded()
    }
    
    func hideLoadingView(){
        self.animationViewHeightConstraint?.constant = 0
        self.animationViewWidthConstraint?.constant = 0
        self.view.layoutIfNeeded()
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
            self.hideLoadingView()
            self.animationView.stop()
        }
    }
    
    func didFinishFetchWithError(message: String) {
        DispatchQueue.main.async {
            self.hideLoadingView()
            self.animationView.stop()
            let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            self.showAdviceView()
        }
    }
    
    func didStartFetch() {
        self.hideAdviceView()
        self.animationView.play()
        self.showLoadingView()
    }
}
