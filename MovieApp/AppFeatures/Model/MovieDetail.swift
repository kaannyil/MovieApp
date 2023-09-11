//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 6.09.2023.
//

import Foundation

struct MovieDetail: Codable {
    let id: Int
    let backDropPath: String
    let posterPath: String
    let title: String
    let voteAverage: Double
    let releaseDate: String
    let genres: [Genre]
    let runtime: Int
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case backDropPath = "backdrop_path"
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case genres, runtime, overview
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

