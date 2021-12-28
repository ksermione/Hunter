//
//  Neighbourhood.swift
//  Hunter
//
//  Created by oksana on 28.12.21.
//

import Foundation
import CoreLocation

enum Neighbourhood: String {
    case friedrichshain = "Friedrichshain"
    case pBerg = "Prenzlauerberg"
    case mitte = "Mitte"
    
    var locations: [CLLocation] {
        switch self {
        case .friedrichshain:
            return [
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.511780, longitude: 13.447278), altitude: CLLocationDistance(100)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.514736, longitude: 13.453595), altitude: CLLocationDistance(100)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.510811, longitude: 13.459893), altitude: CLLocationDistance(100)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.516879, longitude: 13.441221), altitude: CLLocationDistance(100)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.521229, longitude: 13.450614), altitude: CLLocationDistance(100)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.517331, longitude: 13.444411), altitude: CLLocationDistance(100)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.515833, longitude: 13.448728), altitude: CLLocationDistance(100)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.510603, longitude: 13.464341), altitude: CLLocationDistance(100)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.518332, longitude: 13.453958), altitude: CLLocationDistance(100)),
            ]
        case .pBerg:
            return []
        case .mitte:
            return []
        }
    }
//     Friedrichshain {
//        static let locations: [CLLocation] = [
//            CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.511780, longitude: 13.447278), altitude: CLLocationDistance(100)),
//            CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.514736, longitude: 13.453595), altitude: CLLocationDistance(100)),
//            CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.510811, longitude: 13.459893), altitude: CLLocationDistance(100)),
//            CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.516879, longitude: 13.441221), altitude: CLLocationDistance(100)),
//            CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.521229, longitude: 13.450614), altitude: CLLocationDistance(100)),
//            CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.517331, longitude: 13.444411), altitude: CLLocationDistance(100)),
//            CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.515833, longitude: 13.448728), altitude: CLLocationDistance(100)),
//            CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.510603, longitude: 13.464341), altitude: CLLocationDistance(100)),
//            CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.518332, longitude: 13.453958), altitude: CLLocationDistance(100)),
//        ]
//    }
//    struct PBerg {
//        static let locations: [CLLocation] = [
//
//        ]
//    }
//    struct Mitte {
//        static let locations: [CLLocation] = [
//
//        ]
//    }
}
