//
//  MovieGenre+CoreDataProperties.swift
//  MovieApp
//
//  Created by Petar Ljubotina on 19.06.2022..
//
//

import Foundation
import CoreData


extension MovieGenre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieGenre> {
        return NSFetchRequest<MovieGenre>(entityName: "MovieGenre")
    }

    @NSManaged public var action: Bool
    @NSManaged public var adventure: Bool
    @NSManaged public var animation: Bool
    @NSManaged public var comedy: Bool
    @NSManaged public var crime: Bool
    @NSManaged public var documentary: Bool
    @NSManaged public var drama: Bool
    @NSManaged public var family: Bool
    @NSManaged public var fantasy: Bool
    @NSManaged public var horror: Bool
    @NSManaged public var music: Bool
    @NSManaged public var mystery: Bool
    @NSManaged public var romance: Bool
    @NSManaged public var scienceFiction: Bool
    @NSManaged public var tvMovie: Bool
    @NSManaged public var thriller: Bool
    @NSManaged public var war: Bool
    @NSManaged public var western: Bool
    @NSManaged public var movies: MovieEntity?

}

extension MovieGenre : Identifiable {

}
