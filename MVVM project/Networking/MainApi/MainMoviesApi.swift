//
//  MainMoviesApi.swift
//  MVVM project
//
//  Created by 2B on 14/05/2023.
//

import Foundation
import Alamofire

class MainApi : BaseAPI<MainMoviesNetworking>{
 
    func getMovies(completion: @escaping (Result<MoviesModel,NetworkError>)->Void){
         self.fetshData(target: .getData, responceClass: MoviesModel.self) {
            (response) in
             
            switch response {
            case .success(let data):
                if let data = data {
                    completion(.success(data))
                }else{
                    completion(.failure(.cantParseData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
