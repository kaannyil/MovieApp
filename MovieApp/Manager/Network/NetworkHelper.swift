//
//  NetworkHelper.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 6.09.2023.
//

import Foundation

enum ErrorTypes: String, Error {
    case invalidUrl = "Invalid Url"
    case noData = "No Data"
    case invalidRequest = "Invalid Request"
    case generalError = "General Error"
    case parsingError = "Parsing Error"
    case responseError = "Response Error"
}

protocol EndPointProtocol {
    var baseUrl: String { get }
    var apiKey: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var parameters: [String: Any]? { get }
    func request() -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

enum EndPoint {
    case getMovieData(MovieType: String, page: String)
    case getDetailData(id: Int, page: String)
}

extension EndPoint: EndPointProtocol {
    var baseUrl: String {
        return "https://api.themoviedb.org/3/movie/"
    }
    
    var apiKey: String {
        return "f858472ea9ac0dad0db2818b9c7ef82b"
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovieData: return .get
        case .getDetailData: return .get
        }
    }
    
    var path: String {
        switch self {
        case .getMovieData(let movieType, _): return "\(movieType)"
        case .getDetailData(let id, _): return "\(id)"
        }
    }
    
    var header: [String : String]? {
        // var header: [String: String] = ["Content-type": "application/json; charset=UTF-8"]
        // return header
        return nil
    }
    
    var parameters: [String : Any]? {
        
        return nil
    }
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseUrl) else {
            fatalError("URL Error !")
        }
        
        components.path = path
        
        //Add Query Parameters
        if case .getMovieData(_, let page) = self {
            components.queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                                     URLQueryItem(name: "language", value: "en-US"),
                                     URLQueryItem(name: "page", value: page)]
        } else if case .getDetailData(_, let page) = self {
            components.queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                                     URLQueryItem(name: "language", value: "en-US"),
                                     URLQueryItem(name: "page", value: page)]
        }
        
        // Create Request
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        // Common Headers
        // request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        //Add Parameters
        if let parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            }catch {
                print(error.localizedDescription)
            }
        }
        return request
    }
}
