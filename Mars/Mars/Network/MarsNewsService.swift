//
//  MarsNewsService.swift
//  Mars
//
//  Created by 董静 on 10/31/21.
//

import Foundation

class MarsNewsService {
    
    static let shared = MarsNewsService()
    
    // fetch mars news
    func fetchMarsNews(completion: @escaping ((Result<[MarsNews], Error>) -> Void)) {
        MarsRequestManager.shared.basicRequest(url: "articles.json", method: .get, expecting: [MarsNews].self) { result in
            switch result {
            case .success(let news) :
                completion(.success(news))
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
}
