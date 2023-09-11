//
//  MovieData.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 6.09.2023.
//

import Foundation


struct MovieData: Codable {
    let page: Int
    let results: [MovieInfo]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieInfo: Codable {
    let id: Int
    let posterPath: String
    let genreIDs: [Int]
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case genreIDs = "genre_ids"
        case title
    }
}
