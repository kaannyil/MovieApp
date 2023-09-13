//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 6.09.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private func request<T: Codable>(_ endPoint: EndPoint, completion: @escaping (Result<T, ErrorTypes>) -> Void) {
        let task = URLSession.shared.dataTask(with: endPoint.request()) { data, response, error in
            if error != nil {
                completion(.failure(.generalError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode <= 299 else {
                completion(.failure(.responseError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            self.handleResponse(data: data) { response in
                completion(response)
            }
            
        }
        
        task.resume()
    }
    
    func handleResponse <T: Codable>(data: Data, completion: @escaping (Result<T, ErrorTypes>) -> ()) {
        do {
            let successData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(successData))
        } catch {
            print(error)
            completion(.failure(.parsingError))
        }
    }
}

extension NetworkManager {
    func getMovieData(movieType: String, page: String, completion: @escaping (Result<MovieData, ErrorTypes>) -> Void) {
        let endPoint = EndPoint.getMovieData(MovieType: movieType, page: page)
        
        request(endPoint, completion: completion)
    }
    
    func getDetailData(id: Int, page: String, completion: @escaping (Result<MovieDetail, ErrorTypes>) -> Void) {
        let endPoint = EndPoint.getDetailData(id: id, page: page)
        
        request(endPoint, completion: completion)
    }
    
    func getGenreData(completion: @escaping (Result<GenreData, ErrorTypes>) -> Void) {
        let endPoint = EndPoint.getGenreData
        
        request(endPoint, completion: completion)
    }
}
