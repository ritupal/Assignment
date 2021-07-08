//
//  ServiceManager.swift
//  IBMAssignment
//
//  Created by Ritu pal on 07/07/21.
//

import Foundation

class ServiceManager {
    // MARK: - Properties
    static let shared: ServiceManager = ServiceManager()
    
    var baseURL: String = "http://www.mocky.io/v2/5dc3f2c13000003c003477a0"
}

// MARK: - Public Functions
extension ServiceManager {
    
    func sendRequest<T: Codable>(request: RequestModel, completion: @escaping(Swift.Result<[T], ErrorModel>) -> Void) {
        
        URLSession.shared.dataTask(with: request.urlRequest()) { (data, response, error) in
            guard let data = data, let parseResponse = try? JSONDecoder().decode([T].self, from: data) else {
                let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
                completion(Result.failure(error))
                return
            }
            completion(Result.success(parseResponse))
        }.resume()
        
    }
}
