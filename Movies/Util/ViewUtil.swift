//
//  ViewUtil.swift
//  Movies
//
//  Created by padrao on 22/02/20.
//  Copyright © 2020 Williamberg. All rights reserved.
//

import Foundation
import UIKit

struct ViewUtil {
    
    static func prepareWindow(window: UIWindow?) {
        let _window = window ?? UIWindow()
        let navigationViewController = UINavigationController()
        let movieViewController = MovieViewController()
        navigationViewController.viewControllers.append(movieViewController)
        _window.rootViewController = navigationViewController
        _window.makeKeyAndVisible()
    }
}
