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
                // all of fhain - big walk locations
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51087, longitude: 13.45985), altitude: CLLocationDistance(40)), // boxi
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51488, longitude: 13.45366), altitude: CLLocationDistance(44)), // Fr tor
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51169, longitude: 13.44740), altitude: CLLocationDistance(43)), // comeniusplatz
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51590, longitude: 13.44339), altitude: CLLocationDistance(43)), // weberwiese
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51880, longitude: 13.44480), altitude: CLLocationDistance(42)), // auerdreieck
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.52131, longitude: 13.45055), altitude: CLLocationDistance(54)), // petersburger platz
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51944, longitude: 13.46035), altitude: CLLocationDistance(51)), // Fockenbeckplatz
                
                
                
                // local ones for testing near Kadiner
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.511687, longitude: 13.447388), altitude: CLLocationDistance(40)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.512910, longitude: 13.450392), altitude: CLLocationDistance(40)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.513399, longitude: 13.447585), altitude: CLLocationDistance(40)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.514834, longitude: 13.450078), altitude: CLLocationDistance(40)),
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
