//
//  FavoraitsViewModel.swift
//  MVVM project
//
//  Created by 2B on 27/07/2023.
//

import Foundation
import CoreData

protocol FavoraitsViewModelDelegate{
    func deletionDone(message:String)
    func deletionFail(message:String)
}

class FavoraitsViewModel {
    var isLoading : Observable<Bool> = Observable(false)
    var delegate : FavoraitsViewModelDelegate?
    var numberOfItems : Int?
    var filmsArray: [FilmModel] = []
    func numberOfsections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int)->Int{
        numberOfItems ?? 0
    }
    
    func fetchData(){
        isLoading.value = true
        let fetchRequest: NSFetchRequest<Film> = Film.fetchRequest()
        do {
            let fetchedFilms = try context.fetch(fetchRequest)
            
            if fetchedFilms.isEmpty {
                print("No data")
                isLoading.value = false
            } else {
                for film in fetchedFilms {
                    if let title = film.title , let poster_path = film.poster_path, let vote_average = film.vote_average as? Double, let release_date = film.release_date   {
                        let filmObject = FilmModel(title: title, vote_average: vote_average, poster_path: poster_path, release_date: release_date)
                        filmsArray.append(filmObject)
                    }else{
                        print("Can't parse nil object")
                    }
                    numberOfItems = filmsArray.count
                    isLoading.value = false
                    
                }
            }
        } catch {
            print("Error fetching products: \(error)")
        }
    }
    
    func removeDuplication(){
        filmsArray = []
    }
    
    func deleteFromCoreData(indexPath:IndexPath){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Film")
        do{
            let myProduct = try context.fetch(fetchRequest)
            context.delete(myProduct[indexPath.row])
            try context.save() 
            filmsArray.remove(at: indexPath.row)
            numberOfItems = numberOfItems! - 1
            delegate?.deletionDone(message: "Deleted Succefully")
        }catch{
            print(error)
            delegate?.deletionFail(message: "Something went wrong")
        } 
    }
}
