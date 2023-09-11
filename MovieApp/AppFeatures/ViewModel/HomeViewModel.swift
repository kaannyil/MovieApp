//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 4.09.2023.
//

import Foundation
import UIKit

enum MovieType: String {
    case topRated = "top_rated"
    case popular = "popular"
}
protocol HomeViewModelInterfaces {
    var view: HomeView? { get }
    func viewDidLoad()
}

class HomeViewModel: HomeViewModelInterfaces {
    var model: MovieData?
    var view: HomeView?
    
    var homeViewOutPut : HomeViewOutPut?
    
    func viewDidLoad() {
        view?.prepare()
    }
    
    func fetchTopRatedMovies() {
        NetworkManager.shared.getMovieData(movieType: MovieType.topRated.rawValue,
                                           page: "1") { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.homeViewOutPut?.saveMovies(movieType: .topRatedMovies,
                                                    list: success.results)
                    // self.model = success
                    // self.view?.topRatedCollectionView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchPopularMovies() {
        NetworkManager.shared.getMovieData(movieType: MovieType.popular.rawValue,
                                           page: "1") { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.homeViewOutPut?.saveMovies(movieType: .popularMovies,
                                                    list: success.results)
                    // self.model = success
                    // self.view?.popularCollectionView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
            
        }
    }
    
    func segueToDetails(movieID: Int) {
        NetworkManager.shared.getDetailData(id: movieID, page: "1") { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    let vc = DetailsView()
                    vc.viewModel.model = success
                    self.view?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchData() {
        fetchTopRatedMovies()
        fetchPopularMovies()
    }
}
