//
//  Neighbourhood.swift
//  Hunter
//
//  Created by oksana on 28.12.21.
//

import Foundation
import CoreLocation

enum Neighbourhood: String {
    case friedrichshainTest = "Kadiner Test"
    
    case friedrichshain = "Friedrichshain"
    case pBerg = "Prenzlauerberg"
    case mitte = "Mitte"
    
    var locationsFar: [CLLocation] {
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
            ]
        case .friedrichshainTest:
            return [
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
    
    var locationsNear: [CLLocation] {
        switch self {
        case .friedrichshain:
            return [
                // locations near to FR tor
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51532, longitude: 13.45289), altitude: CLLocationDistance(47)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51328, longitude: 13.45292), altitude: CLLocationDistance(41)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51445, longitude: 13.45467), altitude: CLLocationDistance(42)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51589, longitude: 13.45714), altitude: CLLocationDistance(45)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51639, longitude: 13.45222), altitude: CLLocationDistance(48)),
                CLLocation(coordinate: CLLocationCoordinate2D(latitude: 52.51543, longitude: 13.45588), altitude: CLLocationDistance(43)),
            ]
        case .friedrichshainTest:
            return [
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
}
