//
//  UIHelper.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 7.09.2023.
//

import UIKit

enum MovieTypes: String, CaseIterable {
    case topRatedMovies = "Top Rated Movies"
    case popularMovies  = "Popular Movies"
}

struct CellItem {
    let cellType: MovieTypes
    let movieList: [MovieInfo]
}
