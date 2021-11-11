//
//  APIClient.swift
//  UserTest
//
//  Created by 董静 on 11/5/21.
//

import Foundation

class APIClient {
    
    static let shared = APIClient()
    
    func basicRequest(with url: String, method:HTTPMethod, completion: @escaping ((Result<[User], Error>) -> Void)){
        
        guard let requestUrl = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(HTTPError.invalidRequest))
                return
            }
            
            do{
                let json = try JSONDecoder().decode([User].self, from: data)
                completion(.success(json))
                print(json)
            }
            catch{
                
            }
        }
        task.resume()
    }
}

extension APIClient {
    
    enum HTTPMethod : String {
        case get
        case post
    }
    
    enum HTTPError : Error {
        case invalidResponse
        case invalidUrl
        case invalidRequest
    }
}
