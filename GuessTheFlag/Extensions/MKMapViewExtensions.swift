//
//  MKMapViewExtensions.swift
//  GuessTheFlag
//
//  Created by Marcus Ziadé on 31.1.2021.
//  Copyright © 2021 Marcus Ziadé. All rights reserved.
//

import MapKit

extension MKMapView {

    func moveCenterByOffSet(offSet: CGPoint, coordinate: CLLocationCoordinate2D) {
        var point = self.convert(coordinate, toPointTo: self)

        point.x += offSet.x
        point.y += offSet.y

        let center = self.convert(point, toCoordinateFrom: self)
        self.setCenter(center, animated: true)
    }

    func centerCoordinateByOffSet(offSet: CGPoint) -> CLLocationCoordinate2D {
        var point = self.center

        point.x += offSet.x
        point.y += offSet.y

        return self.convert(point, toCoordinateFrom: self)
    }
}
