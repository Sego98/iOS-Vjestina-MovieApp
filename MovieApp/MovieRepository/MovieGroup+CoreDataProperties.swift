//
//  MovieGroup+CoreDataProperties.swift
//  MovieApp
//
//  Created by Petar Ljubotina on 02.06.2022..
//
//

import Foundation
import CoreData


extension MovieGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieGroup> {
        return NSFetchRequest<MovieGroup>(entityName: "MovieGroup")
    }

    @NSManaged public var popular: String?
    @NSManaged public var recommendations: String?
    @NSManaged public var top: String?
    @NSManaged public var trending: String?

}

extension MovieGroup : Identifiable {

}
