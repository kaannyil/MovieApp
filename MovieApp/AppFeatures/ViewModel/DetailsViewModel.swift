//
//  DetailsViewModel.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 4.09.2023.
//

import Foundation

protocol DetailsViewModelInterfaces {
    var view: DetailsView? { get }
    func viewDidLoad()
}

class DetailsViewModel: DetailsViewModelInterfaces {
    
    var model: MovieDetail?
    var view: DetailsView?
    
    func viewDidLoad() {
        view?.prepare()
    }
}
