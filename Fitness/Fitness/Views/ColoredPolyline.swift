//
//  ColoredPolyline.swift
//  Fitness
//
//  Created by Cameron Eubank on 8/7/21.
//

import MapKit
import UIKit

/// `MKPolyline` with a reference to stroke color.
open class ColoredPolyline: MKPolyline {

    /// The stroke color, if any.
    var strokeColor: UIColor?
}
