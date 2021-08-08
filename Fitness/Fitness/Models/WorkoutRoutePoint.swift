//
//  WorkoutRoutePoint.swift
//  Fitness
//
//  Created by Cameron Eubank on 8/7/21.
//

import Foundation
import MapKit

/// Represents a single geographical point during a workout and any associate data captured on the point.
struct WorkoutRoutePoint: Decodable {
    
    /// The coordinate of the point.
    let point: CLLocationCoordinate2D
    
    /// The heart rate captured at the point.
    let heartRate: Int
    
    enum WorkoutRoutePointDecodingError: Error {
        case malformedData
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let array = try container.decode([Double].self)
        guard let lat = array[safeIndex: 0],
              let long = array[safeIndex: 1],
              let heartRate = array[safeIndex: 2] else {
            throw WorkoutRoutePointDecodingError.malformedData
        }
        self.point = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.heartRate = Int(heartRate)
    }
}
