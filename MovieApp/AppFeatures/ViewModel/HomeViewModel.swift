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

var allMoviesUpdated = [MovieInfo]()
var currentPage = 1

class HomeViewModel: HomeViewModelInterfaces {
    
    var model: MovieData?
    var genreModel: GenreData?
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
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchPopularMovies(page: Int = 1, allMovies: [MovieInfo] = []) {
        NetworkManager.shared.getMovieData(movieType: MovieType.popular.rawValue,
                                           page: "\(currentPage)") { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let success):
                
                if currentPage <= 5 {
                    allMoviesUpdated.append(contentsOf: success.results)
                    
                    DispatchQueue.main.async {
                        self.homeViewOutPut?.saveMovies(movieType: .popularMovies,
                                                        list: allMoviesUpdated)
                    }
                    currentPage += 1
                    
                    fetchPopularMovies(page: currentPage, allMovies: allMoviesUpdated)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchGenreData() {
        NetworkManager.shared.getGenreData { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.genreModel = success
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
        fetchGenreData()
    }
}
