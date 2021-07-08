//
//  VehicleAnnotation.swift
//  IBMAssignment
//
//  Created by Ritu pal on 07/07/21.
//

import Foundation
import MapKit

class VehicleAnnotation: NSObject, MKAnnotation {
    let title: String?
    let vehicleName: String?
    let coordinate: CLLocationCoordinate2D
    let imageUrl: String?
    
    init(title: String?, name: String?, imageURL: String? = nil, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.vehicleName = name
        self.coordinate = coordinate
        self.imageUrl = imageURL
        super.init()
    }
    
    var subtitle: String? {
        return vehicleName
    }
}
