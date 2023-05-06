//
//  MainCellViewModel.swift
//  MVVM project
//
//  Created by 2B on 05/05/2023.
//

import Foundation

class MainCellViewModel {
    var id : Int
    var title : String
    var releaseDate : String
    var rate : Double
    var moviePoster : URL?
    
    init(_ movie : Movie) {
        self.id = movie.id
        self.title = movie.title ?? movie.name ?? ""
        self.releaseDate = movie.release_date ?? movie.first_air_date ?? ""
        self.rate = movie.vote_average
        self.moviePoster = imagePosterURL(movie.poster_path)
    }
    
    private func imagePosterURL(_ posterPath : String) -> URL?{
        URL(string: "\(NetworkConstants.shared.ImageServerAddress + posterPath)")
    }
    
}
