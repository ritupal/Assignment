//
//  VehicleTableViewCellModel.swift
//  IBMAssignment
//
//  Created by Ritu pal on 07/07/21.
//

import Foundation

class VehicleTableViewCellModel {

    private let vehicle: Vehicle

    init(vehicle: Vehicle) {
        self.vehicle = vehicle
    }

    var name: String? {
        return vehicle.details.fullName
    }
    
    var image: URL? {
        return vehicle.imageURL
    }
    
    var model: String {
        return vehicle.modelName
    }
    
    var licencePlate: String {
        return vehicle.licensePlate
    }
    
    var type: String {
        return vehicle.type
    }
}
