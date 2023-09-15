//
//  WatchListView.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 1.09.2023.
//

import UIKit

protocol WatchListViewInterfaces {
    func prepare()
}

class WatchListView: UIViewController {

    var viewModel = WatchListViewModel()
    
    let titleAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.white,
        .font: UIFont.boldSystemFont(ofSize: 18)
    ]
    
    let watchListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
        layout.scrollDirection = .vertical
        let sizeHeight = UIScreen.main.bounds.height
        let sizeWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: sizeWidth-40, height: sizeHeight/5)
        layout.minimumLineSpacing = 30
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.layer.cornerRadius = 3
        collection.backgroundColor = .clear
        collection.register(WatchListViewCell.self,
                            forCellWithReuseIdentifier: WatchListViewCell.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
   override func viewDidAppear(_ animated: Bool) {
        viewModel.viewDidAppear()
        super.viewDidAppear(animated)
    }
}

// MARK: - Watch List View Interfaces
extension WatchListView: WatchListViewInterfaces {
    func prepare() {
        view.addSubview(watchListCollectionView)
        
        watchListConst()
        
        title = "Watch List"
        view.backgroundColor = UIColor(named: "system_background_color")
        
        delegates()
    }
}

// MARK: - Delegates
extension WatchListView {
    private func delegates() {
        watchListCollectionView.delegate = self
        watchListCollectionView.dataSource = self
    }
}

// MARK: - CollectionView
extension WatchListView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  viewModel.favArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchListViewCell.identifier,
                                                            for: indexPath) as? WatchListViewCell else {
            return UICollectionViewCell()
        }
        let data = viewModel.favArr[indexPath.item]
        cell.configCell(movieDetail: data, isFavedMovie: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = viewModel.favArr[indexPath.item].id
        viewModel.segueToDetails(movieID: id)
    }
}

// MARK: - Constraints
extension WatchListView {
    private func watchListConst() {
        watchListCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
