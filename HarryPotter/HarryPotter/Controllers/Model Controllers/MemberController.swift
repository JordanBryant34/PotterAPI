//
//  MemberController.swift
//  HarryPotter
//
//  Created by Jordan Bryant on 9/24/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import Foundation

class MemberController {
    
    fileprivate static let baseUrl = "https://www.potterapi.com/v1"
    fileprivate static let apiKey = "$2a$10$czbyY8Pag6egkzhJZ.HZ2Obj.R7La/ZB8tcBJE5Of5TV3xZxMVqZ2"
    
    static func getMember(from id: String, completion: @escaping (Result <Member, PotterServiceError>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/characters/\(id)?key=\(apiKey)") else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.thrownError(error)))
                    return
                }
                
                guard let data = data else { return completion(.failure(.noData)) }
                
                do {
                    let member = try JSONDecoder().decode(Member.self, from: data)
                    completion(.success(member))
                } catch {
                    print("ID: \(id)")
                    return completion(.failure(.thrownError(error)))
                }
            }
        }.resume()
    }
    
    static func getMembersOfHouse(from house: House, completion: @escaping ([Member]) -> Void) {
        let dispatchGroup = DispatchGroup()
        var members: [Member] = []
        
        for member in house.members {
            dispatchGroup.enter()
            
            getMember(from: member) { (result) in
                switch result {
                case .success(let member):
                    members.append(member)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(members)
        }
    }
}
