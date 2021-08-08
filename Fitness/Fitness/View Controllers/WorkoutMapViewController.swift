//
//  WorkoutRouteViewController.swift
//  Fitness
//
//  Created by Cameron Eubank on 8/7/21.
//

import MapKit
import UIKit

/// View controller displaying the route of a workout.
final class WorkoutRouteViewController: UIViewController {
    
    /// The map view displaying the route of the workout.
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.region = mapView.regionThatFits(route.region)
        mapView.isUserInteractionEnabled = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    /// The route containing all points along the route.
    private let route: WorkoutRoute
    
    init() {
        self.route = WorkoutRouteLoader().load()
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Route"
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        reloadMapView()
    }

    private func reloadMapView() {
        // Each MKPolyline needs a start and end position.
        //
        // Create a collection of stand and end points in the route.
        //
        let startAndEndPoints = stride(from: 0, to: route.points.endIndex, by: 2).map {
            (route.points[$0], $0 < route.points.index(before: route.points.endIndex) ? route.points[$0.advanced(by: 1)] : nil)
        }
        
        let userAge = 28 // Assuming we have this persisted.
        
        // For each start and end point, create a ColoredPolyline that represents
        // the average heart rate of the start and end point.
        //
        startAndEndPoints.forEach { startAndEndPoint in
            let coordinates: [CLLocationCoordinate2D] = [startAndEndPoint.0.point, startAndEndPoint.1?.point].compactMap { $0 }
            let polyLine = ColoredPolyline(coordinates: coordinates, count: coordinates.count)
            let averageHeartRate: Int = {
                if let endHeartRate = startAndEndPoint.1?.heartRate {
                    return (startAndEndPoint.0.heartRate + endHeartRate) / 2
                } else {
                    return startAndEndPoint.0.heartRate
                }
            }()
            polyLine.strokeColor = UIColor.representing(averageHeartRate, age: userAge)
            mapView.addOverlay(polyLine)
        }
    }
}

// MARK: - MKMapViewDelegate

extension WorkoutRouteViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? ColoredPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = polyline.strokeColor
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer()
    }
}
