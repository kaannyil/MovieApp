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
    var favIdArr: [Int] = []
    
    func viewDidLoad() {
        view?.prepare()
    }
    
    func fetchWatchListData() {
        CoreDataManager.shared.getDataToWatchList { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let success):
                success.forEach { element in
                    self.favIdArr.append(element.id)
                }
            case .failure(let failure):
                print("Error while importing Core Data Values: \(failure)")
            }
        }
    }
}
