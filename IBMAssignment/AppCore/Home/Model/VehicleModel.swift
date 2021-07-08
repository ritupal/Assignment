//
//  VehicleModel.swift
//  IBMAssignment
//
//  Created by Ritu pal on 07/07/21.
//

import Foundation


struct Vehicle: Codable {
    let id: String
    let modelName: String
    let licensePlate: String
    let image: String
    let details: VehicleDetails
    let imageURL: URL?
    let type: String
    let location: VehicleLocation
}

extension Vehicle {
    private enum CodingKeys: String, CodingKey {
        case id
        case modelName = "modelIdentifier"
        case licensePlate
        case image = "carImageUrl"
        case details = "vehicleDetails"
        case type = "innerCleanliness"
        case location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        modelName = try container.decode(String.self, forKey: .modelName)
        licensePlate = try container.decode(String.self, forKey: .licensePlate)
        type = try container.decode(String.self, forKey: .type)
        image = try container.decode(String.self, forKey: .image)
        details = try container.decode(VehicleDetails.self, forKey: .details)
        location = try container.decode(VehicleLocation.self, forKey: .location)
        imageURL = URL(string: image)
        
    }
}

struct VehicleDetails: Codable {
    let name: String
    let make: String
    let fullName: String?
    
}

extension VehicleDetails {
    private enum CodingKeys: String, CodingKey {
        case name
        case make
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        make = try container.decode(String.self, forKey: .make)
        fullName = make + " " + name
    }
}

struct VehicleLocation: Codable {
    let latitude: Double
    let longitude: Double
}

extension VehicleLocation {
    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
    }
}
