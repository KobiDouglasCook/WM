//
//  ServiceManager.swift
//  I-WarnerMedia
//
//  Created by Kobi Cook on 7/29/21.
//

import Foundation

enum MyError: Error {
    case noData(String)
    case badUrl(String)
}
typealias ProductHandler = ((Result<[Product], MyError>) -> Void)

final class ServiceManager {
    
    static let shared = ServiceManager()
    private init() {}
    
    
    func get(completion: @escaping ProductHandler) {
        
        guard let path = Bundle.main.path(forResource: "products", ofType: "json") else {
            completion(.failure(MyError.badUrl("path is not reachable")))
            return
        }
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Product].self, from: data)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion(.success(decoded))
            }
        } catch {
            completion(.failure(MyError.noData("no data is present")))
        }
    }
    
}
