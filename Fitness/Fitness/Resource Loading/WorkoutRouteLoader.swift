//
//  WorkoutRouteLoader.swift
//  Fitness
//
//  Created by Cameron Eubank on 8/7/21.
//

import Foundation

/// Object that loads a workout route from a JSON resource in the bundle.
struct WorkoutRouteLoader {

    private let bundle: Bundle

    /// Initialize an instance of `WorkoutRouteLoader`
    ///
    /// - Parameter bundle: The bundle to load the resource from, default is `main`.
    ///
    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }
    
    /// Retrieves an instance of `WorkoutRoute` from a JSON resource in the bundle.
    ///
    /// - Returns: A `WorkoutRoute`
    ///
    func load() -> WorkoutRoute {
        do {
            let resourcePath = try Bundle.main.jsonResourceURL(resourceName: "latitude_longitude_heartrate")
            let data = try Data(contentsOf: resourcePath)
            return try JSONDecoder().decode(WorkoutRoute.self, from: data)
        } catch {
            preconditionFailure("Expected to retrieve and decode a WorkoutRoute!")
        }
    }
}

enum JSONBundleResourceError: Error {
    case invalidURLPath
}

private extension Bundle {
    func jsonResourceURL(resourceName: String) throws -> URL {
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: "json") else {
            throw JSONBundleResourceError.invalidURLPath
        }
        return url
    }
}
