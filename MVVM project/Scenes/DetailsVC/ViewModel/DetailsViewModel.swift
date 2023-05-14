//
//  DetailsViewModel.swift
//  MVVM project
//
//  Created by 2B on 06/05/2023.
//

import Foundation

class DetailsViewModel{
    
    //MARK: - Variables
    var movie : Movie
    var movieImage : URL?
    var movieName : String
    var movieDescription : String
    
    init(movie: Movie) {
        self.movie = movie
        self.movieName = movie.name ?? movie.title ?? ""
        self.movieDescription = movie.overview
        self.movieImage = getMovieImageUrl(movie.backdrop_path)
    }

    private func getMovieImageUrl(_ imageCode : String) -> URL?{
        URL(string: "\(NetworkConstants.shared.ImageServerAddress)\(imageCode)")
    }
}
