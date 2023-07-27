//
//  DetailsViewModel.swift
//  MVVM project
//
//  Created by 2B on 06/05/2023.
//

import Foundation
import CoreData

protocol DetailsViewModelDelegate{
    func cashingMovieIsDone(message:String)
    func cashingMovieIsFail(message:String)
}

class DetailsViewModel{
    
    //MARK: - Variables
    var delegate : DetailsViewModelDelegate?
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
    
    func addProductToCoreData(){
         let entity = NSEntityDescription.insertNewObject(forEntityName: "Film", into: context) as? Film

        entity?.poster_path = getMovieImageUrl(movie.poster_path)
        entity?.title = movie.title ?? movie.name ?? ""
        entity?.release_date = movie.release_date ?? movie.first_air_date ?? ""
        entity?.vote_average = movie.vote_average
        do{
            try context.save()
            delegate?.cashingMovieIsDone(message: "Added Successfully")
        }catch{
            print(error , "hhhhhhhhhh")
            delegate?.cashingMovieIsFail(message: "Somthing went wrong")
        }
    }
}
