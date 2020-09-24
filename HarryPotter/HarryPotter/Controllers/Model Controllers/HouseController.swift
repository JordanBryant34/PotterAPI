//
//  HouseController.swift
//  HarryPotter
//
//  Created by Jordan Bryant on 9/23/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import Foundation

class HouseController {
    
    fileprivate static let baseUrl = "https://www.potterapi.com/v1"
    fileprivate static let apiKey = "$2a$10$czbyY8Pag6egkzhJZ.HZ2Obj.R7La/ZB8tcBJE5Of5TV3xZxMVqZ2"
    fileprivate static let houseComponent = "houses"
    
    static func getHouses(completion: @escaping (Result <[House], PotterServiceError>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/houses?key=\(apiKey)") else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.thrownError(error)))
                    return
                }
                
                guard let data = data else { return completion(.failure(.noData)) }
                
                do {
                    let houses = try JSONDecoder().decode([House].self, from: data)
                    
                    completion(.success(houses))
                } catch {
                    return completion(.failure(.thrownError(error)))
                }
            }
        }.resume()
    }
}
