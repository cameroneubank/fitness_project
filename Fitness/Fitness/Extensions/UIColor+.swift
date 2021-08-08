//
//  UIColor+.swift
//  Fitness
//
//  Created by Cameron Eubank on 8/7/21.
//

import UIKit

extension UIColor {
    
    /// The color representing a dangerously elevated heart rate.
    static let danger: UIColor = UIColor(named: "danger")!
    
    /// Returns a color for a given heart rate.
    /// 
    /// - Parameter heartRate: The heart rate to retrieve the representing color of.
    /// - Returns: The color representing the heart rate.
    ///
    static func representing(_ heartRate: Int, age: Int) -> UIColor {
        let maxHeartRate: Int = 220
        let maximumHeartRate = Double(maxHeartRate) - Double(age)
        
        let intensityPercentage: Double = (Double(heartRate) / maximumHeartRate) * 100
        
        switch intensityPercentage {
        case let i where i <= 70: return .systemBlue
        case 71..<81: return .systemGreen
        case 81..<91: return .systemOrange
        case 91..<100: return .systemRed
        case let i where i >= 100: return .danger
        default: return .systemBlue // Should never happen.
        }
    }
}
