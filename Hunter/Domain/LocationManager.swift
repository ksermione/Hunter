//
//  LocationViewModel.swift
//  Hunter
//
//  Created by oksana on 26.10.21.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var updatedLocation: CLLocation?
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    var currentLocation: CLLocation? {
        return locationManager.location
    }
    
    func distance(to destination: CLLocation?) -> Double {
        guard let destination = destination, let currentLocation = updatedLocation else { return 100.0 }
        return Double(currentLocation.distance(from: destination))
    }
    
    func visualDistance(to destination: CLLocation?) -> (Double, String) {
        guard let destination = destination, let currentLocation = updatedLocation else { return (100.0, "error") }
        var distance = Double(currentLocation.distance(from: destination))
        let unit = distance >= 1000.0 ? "km" : "m"
        if distance >= 1000 {
            distance = distance / 1000
        }
        
        return (distance.rounded(toPlaces: 1), unit)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updatedLocation = locations.first
    }
}
