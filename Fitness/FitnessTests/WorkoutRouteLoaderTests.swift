//
//  WorkoutRouteLoaderTests.swift
//  FitnessTests
//
//  Created by Cameron Eubank on 8/7/21.
//

@testable import Fitness
import XCTest

final class WorkoutRouteLoaderTests: XCTestCase {
    
    func test_workoutRouteLoader_loadsRoute() {
        let loader = WorkoutRouteLoader()
        _ = loader.load()
        // Implicit pass.
    }
}
