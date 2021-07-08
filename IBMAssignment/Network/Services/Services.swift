//
//  Services.swift
//  IBMAssignment
//
//  Created by Ritu pal on 07/07/21.
//

import Foundation

struct Services {
    
    func vehiclesList(completion: @escaping(Swift.Result<[Vehicle], ErrorModel>) -> Void) {
        ServiceManager.shared.sendRequest(request: RequestModel()) { (result: Result<[Vehicle], ErrorModel>) in
            print("RESULT:\(result)")
            completion(result)
        }
    }
}
