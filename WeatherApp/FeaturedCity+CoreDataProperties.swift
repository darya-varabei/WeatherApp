//
//  FeaturedCity+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Darya on 9/24/21.
//
//

import Foundation
import CoreData


extension FeaturedCity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeaturedCity> {
        return NSFetchRequest<FeaturedCity>(entityName: "FeaturedCity")
    }

    @NSManaged public var cityName: String?

}

extension FeaturedCity : Identifiable {

}
