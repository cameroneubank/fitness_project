//
//  Array+.swift
//  Fitness
//
//  Created by Cameron Eubank on 8/7/21.
//

import Foundation

extension Array {
    
    /// Returns the element, if one exists, at a specified index.
    ///
    /// - Parameter i: The index for the element.
    /// - Returns: The element at the index if it exists, `nil` if otherwise.
    ///
    /// - Note: The will never cause an index out of bounds exception.
    ///
    subscript(safeIndex i: Int) -> Element? {
        guard (0..<count).contains(i) else {
            return nil
        }
        return self[i]
    }
}
