//
//  MoviesCasheModel.swift
//  MVVM project
//
//  Created by 2B on 18/07/2023.
//

import Foundation
import RealmSwift

class MoviesCasheModel: Object {
    let results = List<MovieCashed>()
}

class MovieCashed: Object {
    @objc dynamic var adult: Bool = true
    @objc dynamic var backdrop_path: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var original_title: String = ""
    @objc dynamic var overview :String = ""
    @objc dynamic var poster_path: String = ""
    @objc dynamic var popularity: Double = 0
    @objc dynamic var release_date: String = ""
    @objc dynamic var video: Bool = true
    @objc dynamic var vote_average: Double = 0.0
    @objc dynamic var vote_count: Int = 0
    @objc dynamic var name : String = ""
    @objc dynamic var original_name: String = ""
    @objc dynamic var first_air_date: String = ""
    let origin_country = List<String>()

    override static func primaryKey() -> String? {
            return "id"
    }
}
