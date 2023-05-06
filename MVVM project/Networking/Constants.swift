//
//  Constants.swift
//  MVVM project
//
//  Created by 2B on 02/05/2023.
//

import Foundation


class NetworkConstants{
    
    public static var shared : NetworkConstants = NetworkConstants()
    
    
    
     let apiKey = "92fbd4e1831ee2c738c7ab50985f966f"
     let serverAddress = "https://api.themoviedb.org/3/trending/all/day?api_key="
     let ImageServerAddress = "https://image.tmdb.org/t/p/w185/"
    
    
    private init(){
        
    }
}
