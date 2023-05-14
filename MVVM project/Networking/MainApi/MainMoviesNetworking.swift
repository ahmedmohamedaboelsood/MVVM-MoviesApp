//
//  MainApi.swift
//  MVVM project
//
//  Created by 2B on 02/05/2023.
//

import Foundation
import Alamofire

enum MainMoviesNetworking{
    case getData
}

extension MainMoviesNetworking : TargetType{
    var baseURL: String {
        switch self{
        case .getData:
            return NetworkConstants.shared.serverAddress
        }
    }
    var path: String {
        switch self{
        case .getData:
            return NetworkConstants.shared.apiKey
        }
    }
    var method: HTTPMethod {
        switch self{
        case .getData:
            return .get
        }
    }
    var task: Task {
        switch self{
        case .getData:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}
