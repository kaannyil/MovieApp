//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 4.09.2023.
//

import Foundation
import UIKit

protocol HomeViewModelInterfaces {
    var view: HomeView? { get }
    func viewDidLoad()
}

class HomeViewModel: HomeViewModelInterfaces {
    var view: HomeView?
    
    func viewDidLoad() {
        view?.prepare()
    }
    
    public func didSelectItemAt() {
        let detailsView = DetailsView()
        detailsView.backGroundImage.image = UIImage(named: "movie2_background")
        detailsView.foreGroundImage.image = UIImage(named: "movie2")
        detailsView.nameLabel.text = "Spiderman No Way Home"
        detailsView.aboutMovieDetailLabel.text = "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences."
        view?.navigationController?.pushViewController(detailsView, animated: true)
    }
}
