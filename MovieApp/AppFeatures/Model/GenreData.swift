//
//  GenreData.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 12.09.2023.
//

import Foundation

struct GenreData: Codable {
    let genres: [GenreInfo]
}

struct GenreInfo: Codable {
    let id: Int?
    let name: String?
}
