//
//  BaseTabBarVC.swift
//  MVVM project
//
//  Created by 2B on 26/07/2023.
//

import UIKit

class BaseTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        let VC1 = MainVC()
        VC1.title = "Movies"
        let mainImage = UIImage(systemName: "film")
        let mainSelectedImage = UIImage(systemName: "film.fill")
        let mainTabBarItem = UITabBarItem(title: "Home", image: mainImage, selectedImage: mainSelectedImage)
        VC1.tabBarItem = mainTabBarItem
        let VC2 = FavouriteVC()
        VC2.title = "Favourites"
        let favImage = UIImage(systemName: "star")
        let favSelectedImage = UIImage(systemName: "star.fill")
        let favTabBarItem = UITabBarItem(title: "Favourits", image: favImage, selectedImage: favSelectedImage)
        VC2.tabBarItem = favTabBarItem
        tabBar.tintColor = .gray
        self.viewControllers = [VC1,VC2]
    }
}
