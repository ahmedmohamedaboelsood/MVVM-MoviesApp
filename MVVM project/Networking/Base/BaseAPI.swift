//
//  BaseAPI.swift
//  MVVM project
//
//  Created by 2B on 14/05/2023.
//

import Foundation
import Alamofire
enum NetworkError : Error{
    case urlError
    case cantParseData
    case not200
}

class BaseAPI<T:TargetType>{
    
    func fetshData<M:Decodable>(target:T,responceClass:M.Type,completion:@escaping(Result<M?,NetworkError>)->Void){
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let parameters = buildParams(task: target.task)
        AF.request(target.baseURL + target.path, method: method, parameters: parameters.0, encoding: parameters.1, headers: headers).responseDecodable(of:M.self){response in
            
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(.urlError))
                return
            }
            if statusCode == 200 {
                switch response.result{
                case .success(let data):
                    completion(.success(data))
                case .failure(_):
                    completion(.failure(.cantParseData))
                }
            }else{
                completion(.failure(.not200))
            }
        }
    }
    
    private func buildParams(task : Task)->([String:Any],ParameterEncoding){
        switch task{
        case .requestPlain:
            return ([:],URLEncoding.default)
        case .requestParameters(parametes: let parametes, encoding: let encoding):
            return (parametes,encoding)
        }
    }
}
