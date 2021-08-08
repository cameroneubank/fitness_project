//
//  Array+Tests.swift
//  FitnessTests
//
//  Created by Cameron Eubank on 8/7/21.
//

@testable import Fitness
import XCTest

final class ArrayExtensionsTests: XCTestCase {

    func test_indexesInArray_haveElement() {
        let array: [Int] = [0]
        XCTAssertNotNil(array[safeIndex: 0])
    }
    
    func test_indexesInArray_haveNilElement() {
        let array: [Int] = [0]
        XCTAssertNil(array[safeIndex: -1])
        XCTAssertNil(array[safeIndex: 1])
        XCTAssertNil(array[safeIndex: 2])
    }
}
    
