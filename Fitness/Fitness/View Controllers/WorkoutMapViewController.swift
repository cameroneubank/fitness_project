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
        addRouteStartAndEnd()
        addRoutePolyline()
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

// MARK: - Map Decorating

private extension WorkoutRouteViewController {
    
    /// Adds an annotation for the start and end points in the route to `mapView`, if they exist.
    func addRouteStartAndEnd() {
        var annotations = [MKAnnotation]()
        if let first = route.points.first {
            let annotation = MKPointAnnotation()
            annotation.coordinate = first.point
            annotation.title = "Start"
            annotations.append(annotation)
        }
        if let last = route.points.last {
            let annotation = MKPointAnnotation()
            annotation.coordinate = last.point
            annotation.title = "End"
            annotations.append(annotation)
        }
        mapView.showAnnotations(annotations, animated: false)
    }

    /// Adds multiple polylines to `mapView` of different colors to show the path of the route,
    /// and variations in heart rate over the course of the route.
    func addRoutePolyline() {
        // We'll use the user's age to
        // determine what percentage of the user's maximum heart rate
        // is used at a particular point.
        //
        // This assumes we might have this persisted somewhere.
        //
        let userAge = 28
        
        // This logic iterates over all points in the route, and creates a polyline that starts
        // at the current point and ends at the next point.
        //
        // The polyline created is colored with a color that represents the average heart rate
        // between the start and end coordinate of the point.
        //
        route.points.enumerated().forEach { i, point in
            let points: [WorkoutRoutePoint] = [point, route.points[safeIndex: i + 1]].compactMap { $0 }
            let coordinates: [CLLocationCoordinate2D] = points.map { $0.point }
            let polyLine = ColoredPolyline(coordinates: coordinates, count: coordinates.count)
            
            let averageHeartRate: Int = {
                guard let startHeartRate = points.first?.heartRate else { return 60 }
                if let endHeartRate = points.last?.heartRate {
                    return (startHeartRate + endHeartRate) / 2
                } else {
                    return startHeartRate
                }
            }()

            polyLine.strokeColor = UIColor.representing(averageHeartRate, age: userAge)
            mapView.addOverlay(polyLine)
        }
    }
}

