//
//  MovieGroup+CoreDataProperties.swift
//  MovieApp
//
//  Created by Petar Ljubotina on 19.06.2022..
//
//

import Foundation
import CoreData


extension MovieGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieGroup> {
        return NSFetchRequest<MovieGroup>(entityName: "MovieGroup")
    }

    @NSManaged public var popular: Bool
    @NSManaged public var recommended: Bool
    @NSManaged public var trending: Bool
    @NSManaged public var top: Bool
    @NSManaged public var movies: MovieEntity?

}

extension MovieGroup : Identifiable {

}
