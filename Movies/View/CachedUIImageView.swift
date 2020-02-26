//
//  CachedUIImageView.swift
//  Movies
//
//  Created by padrao on 23/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import Foundation
import UIKit

class CachedUIImageView: UIImageView{
    let imageCache = NSCache<NSString, UIImage>()
    weak var dataTask: URLSessionDataTask?

    
    /// It downloads the image from a server, save it on cache and set the image of UIImageView. If the image  exists on cache just sets the image of UIImageView from cache.
    /// - Parameter url: The image url.
    func load(url: URL){
        if let image = self.imageCache.object(forKey: url.absoluteString as NSString){
            self.image = image
        }
        else{
            DispatchQueue.global().async {
                [weak self] in
                if let data = try? Data(contentsOf: url){
                    if let image = UIImage(data: data){
                        self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
    
}
