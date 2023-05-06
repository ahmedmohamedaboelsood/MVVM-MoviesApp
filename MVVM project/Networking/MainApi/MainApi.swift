//
//  MainApi.swift
//  MVVM project
//
//  Created by 2B on 02/05/2023.
//

import Foundation
import Alamofire

enum NetworkError : Error{
    case urlError
    case cantParseData
    case not200
}



class MainApi{
    
    static func getMovies(completion:@escaping (Result<MoviesModel,NetworkError>) -> Void){
        let urlString = NetworkConstants.shared.serverAddress + NetworkConstants.shared.apiKey
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        
        
        AF.request(url, method: .get ).responseDecodable(of:MoviesModel.self){res in
            if res.response?.statusCode == 200 {
                switch res.result{
                case .success(let data):
                    completion(.success(data))
                case .failure(let fail):
                    print(fail)
                    completion(.failure(.cantParseData))
                }
            }else{
                completion(.failure(.not200))
            }
        } 
    }
    
    
    
    
    
    
    
}
