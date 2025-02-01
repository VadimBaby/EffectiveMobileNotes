//
//  NetworkService.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 28.01.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func getTodos(completion: @escaping (_ result: Result<[TODO], Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    private let baseURL = "https://dummyjson.com"
    
    func getTodos(completion: @escaping (_ result: Result<[TODO], Error>) -> Void) {
        execute(endpoint: .todos) { (result: Result<ServerTODOSResponseModel, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let serverResponse):
                    guard let response = TODOResponse(from: serverResponse) else {
                        completion(.failure(URLError(.badServerResponse)))
                        return
                    }
                    
                    completion(.success(response.todos))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

private extension NetworkService {
    func execute<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (_ result: Result<T, Error>) -> Void) {
        let stringURL = baseURL + "/" + endpoint.rawValue
        
        guard let url = URL(string: stringURL) else { completion(.failure(URLError(.badURL))); return }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
           if let data, let serverResponse = try? JSONDecoder().decode(T.self, from: data) {
               completion(.success(serverResponse))
           } else if let error {
               completion(.failure(error))
           } else {
               completion(.failure(URLError(.badServerResponse)))
           }
        }
        
        task.resume()
    }
}
