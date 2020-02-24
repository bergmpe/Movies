//
//  MovieColletionViewCell.swift
//  Movies
//
//  Created by padrao on 22/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    lazy var movieImageView: UIImageView = {
        let obj = UIImageView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFit
        obj.image = UIImage(named: "multimedia_placeholder")
        return obj
    }()
    
    override func didMoveToSuperview() {
        self.setup()
    }
    
    private func setup() {
        
        self.contentView.backgroundColor = .black
        
        self.contentView.addSubview(self.movieImageView)
        self.movieImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.movieImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.movieImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.movieImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
}

