//
//  Color+Tests.swift
//  FitnessTests
//
//  Created by Cameron Eubank on 8/7/21.
//

@testable import Fitness
import XCTest

final class ColorExtensionsTests: XCTestCase {
    
    func test_colorForLightHeartRate_isBlue() {
        (0...136).forEach { i in
            let color = UIColor.representing(i, age: 28)
            XCTAssertEqual(color, .systemBlue)
        }
    }
    
    func test_colorForElevatedHeartRate_isGreen() {
        (137...155).forEach { i in
            let color = UIColor.representing(i, age: 28)
            XCTAssertEqual(color, .systemGreen)
        }
    }
    
    func test_colorForConsiderablyElevatedHeartRate_isOrange() {
        (156...174).forEach { i in
            let color = UIColor.representing(i, age: 28)
            XCTAssertEqual(color, .systemOrange)
        }
    }
    
    func test_colorForHighlyElevatedHeartRate_isRed() {
        (175...191).forEach { i in
            let color = UIColor.representing(i, age: 28)
            XCTAssertEqual(color, .systemRed)
        }
    }
    
    func test_colorForDangerouslyElevatedHeartRate_isDanger() {
        (192...220).forEach { i in
            let color = UIColor.representing(i, age: 28)
            XCTAssertEqual(color, .danger)
        }
    }
}
