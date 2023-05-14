//
//  MoviesModel.swift
//  MVVM project
//
//  Created by 2B on 02/05/2023.
//
import Foundation

struct MoviesModel: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
        let adult: Bool
        let backdrop_path: String
        let id: Int
        let title: String?
        let original_title: String?
        let overview, poster_path: String
        let popularity: Double
        let release_date: String?
        let video: Bool?
        let vote_average: Double
        let vote_count: Int
        let name, original_name, first_air_date: String?
        let origin_country: [String]?
}
