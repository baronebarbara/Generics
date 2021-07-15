//
//  Service.swift
//  Generics
//
//  Created by Barbara Barone on 15/07/21.
//

import Foundation

enum ServiceError: Error {
    case generic
}

class Service<T: Decodable> {
    func method(banana: @escaping (Result<[T], ServiceError>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: "https://api.github.com/users/baronebarbara/repos") else { return }
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let decode = JSONDecoder()
            decode.keyDecodingStrategy = .convertFromSnakeCase
            DispatchQueue.main.async {
                do {
                   let decoded = try decode.decode([T].self, from: data)
                    banana(.success(decoded))
                } catch {
                    banana(.failure(.generic))
                }
            }
        }
        task.resume()
    }
}


