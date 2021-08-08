//
//  WorkoutRoute.swift
//  Fitness
//
//  Created by Cameron Eubank on 8/7/21.
//

import Foundation
import MapKit

/// Represents a route during a workout.
struct WorkoutRoute: Decodable {
    
    /// The collection of points.
    let points: [WorkoutPoint]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.points = try container.decode([WorkoutPoint].self)
    }
}

extension WorkoutRoute {
    
    /// The coordinate region encompassing all points within the route.
    var region: MKCoordinateRegion {
        var maxLatitude: Double = -200
        var maxLongitude: Double = -200
        var minLatitude: Double = Double(MAXFLOAT)
        var minLongitude: Double = Double(MAXFLOAT)
        
        points.map { $0.point }.forEach { location in
            minLatitude = min(minLatitude, location.latitude)
            minLongitude = min(minLongitude, location.longitude)
            maxLatitude = max(maxLatitude, location.latitude)
            maxLongitude = max(maxLongitude, location.longitude)
        }

        let span = MKCoordinateSpan(latitudeDelta: maxLatitude - minLatitude,
                                    longitudeDelta: maxLongitude - minLongitude)
        let center = CLLocationCoordinate2D(latitude: maxLatitude - (span.latitudeDelta / 2),
                                            longitude: maxLongitude - (span.longitudeDelta / 2))
        return MKCoordinateRegion(center: center, span: span)
    }
}
