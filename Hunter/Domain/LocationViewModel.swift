//
//  LocationViewModel.swift
//  Hunter
//
//  Created by oksana on 26.10.21.
//

import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location updated! \(locations)")
//        guard let loc = locations.first els
        updatedLocation = locations.first
    }
}
