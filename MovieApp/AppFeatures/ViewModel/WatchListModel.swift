//
//  WatchListModel.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 4.09.2023.
//

import Foundation
import UIKit

protocol WatchListViewModelInterfaces {
    var view: WatchListView? { get set }
    func viewDidLoad()
}

class WatchListViewModel: WatchListViewModelInterfaces {
    var view: WatchListView?
    
    var favArr: [MovieDetail] = []
    
    func viewDidLoad() {
        view?.prepare()
    }
    
    func viewDidAppear() {
        fetchWatchListData()
    }
    
    private func fetchWatchListData() {
        CoreDataManager.shared.getDataToWatchList { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let success):
                self.favArr = []
                
                success.forEach { element in
                    self.favArr.append(element)
                }
                DispatchQueue.main.async {
                    self.view?.watchListCollectionView.reloadData()
                }
            case .failure(let failure):
                print("Error while importing Core Data Values: \(failure)")
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
    
    func didSelectItemAt() {
        let detailsView = DetailsView()
        detailsView.backGroundImage.image = UIImage(named: "movie2_background")
        detailsView.foreGroundImage.image = UIImage(named: "movie2")
        detailsView.nameLabel.text = "Spiderman"
        detailsView.aboutMovieDetailLabel.text = "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences."
        view?.navigationController?.pushViewController(detailsView, animated: true)
    }
}
