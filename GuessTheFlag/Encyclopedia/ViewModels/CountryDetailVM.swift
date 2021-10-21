//
//  CountryDetailVM.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 25.9.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import Combine
import CoreLocation
import Foundation
import MapKit

final class CountryDetailVM: ObservableObject {

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384),
        span: MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8)
    )

    init(coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8)
        )
    }
}
