//
//  HomeViewModel.swift
//  IBMAssignment
//
//  Created by Ritu pal on 07/07/21.
//

import Foundation

 class VehicleViewModel {
    
    private let services = Services()
    
    public var vehicles: [Vehicle]?
    
    public func getVehicleList(completion: ((_ error: String?) -> Void)?) {
        services.vehiclesList { [weak self] (result) in
            switch result {
            case .success(let response):
                print("Response \(response)")
                self?.vehicles = response
                completion?(nil)
                break
            case .failure(let error):
                completion?(error.message)
                print("Error in api \(error.message)")
                break
            }
        }
    }
    
    public func cellViewModel(at index: Int) -> VehicleTableViewCellModel? {
        guard let vehicles = vehicles, vehicles.count > 0 else { return nil }
        let vehicleTableViewCellModel = VehicleTableViewCellModel(vehicle: vehicles[index])
        return vehicleTableViewCellModel
    }
    
    public var count: Int {
        return vehicles?.count ?? 0
    }
}


