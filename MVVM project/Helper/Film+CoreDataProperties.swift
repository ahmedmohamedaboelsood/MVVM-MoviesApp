//
//  Film+CoreDataProperties.swift
//  
//
//  Created by 2B on 27/07/2023.
//
//

import Foundation
import CoreData 

extension Film {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Film> {
        return NSFetchRequest<Film>(entityName: "Film")
    }

    @NSManaged public var title: String?
    @NSManaged public var release_date: String?
    @NSManaged public var poster_path: URL?
    @NSManaged public var vote_average: Double

}
