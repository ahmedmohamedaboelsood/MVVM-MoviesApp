//
//  MainViewModel.swift
//  MVVM project
//
//  Created by 2B on 02/05/2023.
//

import Foundation
import RealmSwift

protocol MainViewModelDelegate{
    func getcashedDataDelegate(message : String)
    func getRemoteDataDelegate()
}

class MainViewModel {
    
    //MARK: - Variables
    var isLoading : Observable<Bool> = Observable(false)
    var cashedCellDataSourse : Observable<[MainCellViewModel]> = Observable(nil)
    var cellDataSourse : Observable<[MainCellViewModel]> = Observable(nil)
    var dataSourse : MoviesModel?
    var numberOfRows : Int?
    var MoviesApi = MainApi()
    var delegate : MainViewModelDelegate?
    //MARK: - TABLEVIEW
    func numberOfsections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int)->Int{
        numberOfRows ?? 0
    }
    //MARK: - Functions
    func getData(){
        isLoading.value = true
        MoviesApi.getMovies { result in
            self.isLoading.value = false
            switch result{
            case .success(let data):
                self.delegate?.getRemoteDataDelegate()
                self.saveMoviesData(self.convertDataToMoviesCasheModel(data))
                self.dataSourse = data
                self.numberOfRows = self.dataSourse?.results.count
                self.mapData()
            case .failure(_): 
                self.cashedCellDataSourse.value = self.fetchCachedData().compactMap({ MainCellViewModel($0)})
                self.numberOfRows = self.fetchCachedData().count
                self.delegate?.getcashedDataDelegate(message: "Check InternetConnection")
            }
        }
    }
    
    func setMovieName(_ movie : Movie) -> String{
        return movie.name ?? movie.title ?? ""
    }
    
    func mapData(){
        self.cellDataSourse.value = self.dataSourse?.results.compactMap({MainCellViewModel($0)
        })
    }
    
    func retrieMovie(movieID : Int) -> Movie? {
        guard let remoteMovie = dataSourse?.results.first(where:{$0.id == movieID}) else {
            guard let cashedMovie = fetchCachedData().first(where:{$0.id == movieID}) else {return nil} 
            return cashedMovie
        }
        return remoteMovie
    }
    
    func convertDataToMoviesCasheModel(_ data : MoviesModel) -> [MovieCashed]{
        let movieObjects = data.results.map { movie in
            let movieObject = MovieCashed()
            movieObject.id = movie.id
            movieObject.adult = movie.adult
            movieObject.backdrop_path = movie.backdrop_path
            movieObject.title = movie.title ?? movie.name ??  movie.original_name ?? movie.original_title ?? ""
            movieObject.original_title = movie.original_title ?? ""
            movieObject.overview = movie.overview
            movieObject.poster_path = movie.poster_path
            movieObject.popularity = movie.popularity
            movieObject.release_date = movie.release_date ?? movie.first_air_date ?? ""
            movieObject.video = movie.video ?? false
            movieObject.vote_average = movie.vote_average
            movieObject.vote_count = movie.vote_count
            movieObject.name = movie.name ?? movie.title ?? ""
            movieObject.original_name = movie.original_name ?? ""
            movieObject.first_air_date = movie.first_air_date ?? ""
            return movieObject
        }
        return movieObjects
    }
    
    func saveMoviesData(_ movies : [MovieCashed]){
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(movies, update: .all)
                print("Saved")
            }
        } catch let error as NSError {
            print("Error saving data to Realm: \(error.localizedDescription)")
        }
    }
    
    func fetchCachedData() -> [Movie] {
        do {
            let realm = try Realm()
            let movieObjects = realm.objects(MovieCashed.self)
            let cachedMovies: [Movie] = movieObjects.map { movieObject in
                return Movie(
                    adult: movieObject.adult,
                    backdrop_path: movieObject.backdrop_path,
                    id: movieObject.id,
                    title: movieObject.title,
                    original_title: movieObject.original_title,
                    overview: movieObject.overview,
                    poster_path: movieObject.poster_path,
                    popularity: movieObject.popularity,
                    release_date: movieObject.release_date,
                    video: movieObject.video,
                    vote_average: movieObject.vote_average,
                    vote_count: movieObject.vote_count,
                    name: movieObject.name,
                    original_name: movieObject.original_name,
                    first_air_date: movieObject.first_air_date, origin_country: [])
                
            }
            return cachedMovies
        } catch let error as NSError {
            print("Error fetching cached data from Realm: \(error.localizedDescription)")
            return []
        }
    }
    
}
