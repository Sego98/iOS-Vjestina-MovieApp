//
//  MovieGenre+CoreDataProperties.swift
//  MovieApp
//
//  Created by Petar Ljubotina on 02.06.2022..
//
//

import Foundation
import CoreData


extension MovieGenre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieGenre> {
        return NSFetchRequest<MovieGenre>(entityName: "MovieGenre")
    }

    @NSManaged public var fantasy: Bool
    @NSManaged public var adventure: Bool
    @NSManaged public var action: Bool
    @NSManaged public var fiction: Bool
    @NSManaged public var science: Bool
    @NSManaged public var drama: Bool
    @NSManaged public var crime: Bool
    @NSManaged public var thriller: Bool
    @NSManaged public var comedy: Bool
    @NSManaged public var family: Bool
    @NSManaged public var romance: Bool

}

extension MovieGenre : Identifiable {

}
