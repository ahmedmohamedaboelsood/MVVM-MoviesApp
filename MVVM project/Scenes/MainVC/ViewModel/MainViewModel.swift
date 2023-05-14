//
//  MainViewModel.swift
//  MVVM project
//
//  Created by 2B on 02/05/2023.
//

import Foundation

class MainViewModel {
    
    //MARK: - Variables
    var isLoading : Observable<Bool> = Observable(false)
    var cellDataSourse : Observable<[MainCellViewModel]> = Observable(nil)
    var dataSourse : MoviesModel?
    var MoviesApi = MainApi()
    //MARK: - TABLEVIEW
    func numberOfsections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int)->Int{
        dataSourse?.results.count ?? 0
    }
    //MARK: - Functions
    func getData(){
        isLoading.value = true
        
        MoviesApi.getMovies { result in
            self.isLoading.value = false
            switch result{
            case .success(let data):
                self.dataSourse = data
                print(self.dataSourse!)
                self.mapData()
            case .failure(let error):
                print(error)
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
        guard let movie = dataSourse?.results.first(where:{$0.id == movieID}) else {
            return nil
        }
        return movie
    }
    
}
