//
//  MarsRequestManager.swift
//  Mars
//
//  Created by 董静 on 10/31/21.
//

import Foundation

class MarsRequestManager {
    
    static let shared = MarsRequestManager()
    
    private let session : URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    /// Mars basic request
    /// - Parameters:
    ///   - url: url string
    ///   - method: http method
    ///   - completion: completion block
    func basicRequest<T: Codable> (
        url: String,
        method:HTTPMethod,
        expecting:T.Type,
        completion: @escaping (Result<T,Error>) -> Void) {
        
        let urlString = Constants.baseURL + url
        guard let requestUrl = URL(string: urlString) else {
            completion(.failure(HTTPError.invalidURL))
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(HTTPError.invalidRequest))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(HTTPError.invalidResponse))
                return
            }
            do {
                let json = try! JSONDecoder().decode(expecting, from: data)
                completion(.success(json))
                print(json)
            } catch {
                print("error:", error)
            }
        }
        task.resume()
    }
    
    /// image request
    /// - Parameters:
    ///   - url: image url
    ///   - completion: image data
    func requestImage (
        url: String,
        completion: @escaping (Result<Data,Error>) -> Void) {
        
        guard let requestUrl = URL(string: url) else {
            completion(.failure(HTTPError.invalidURL))
            return
        }
        
        let dowloadTask = session.downloadTask(with: requestUrl) { localUrl, response, error in
            
            guard error == nil else {
                completion(.failure(HTTPError.invalidRequest))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(HTTPError.invalidResponse))
                return
            }
            
            guard let localUrl = localUrl else {
                return
            }
            do {
                let data = try! Data(contentsOf: localUrl)
                completion(.success(data))
            } catch {
                print("error:", error)
            }
        }
        dowloadTask.resume()
    }
}

extension MarsRequestManager {
    
    enum HTTPError: Error {
        case invalidURL
        case invalidRequest
        case invalidResponse
    }
    
    enum HTTPMethod: String {
        case get    = "GET"
        case post   = "POST"
        case delete = "DELETE"
        case put    = "PUT"
    }
    
    struct Constants {
        static let baseURL = "https://s1.nyt.com/ios-newsreader/candidates/test/"
    }
}
