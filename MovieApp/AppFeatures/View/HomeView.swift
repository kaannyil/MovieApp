//
//  ViewController.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 1.09.2023.
//

import UIKit.UICollectionView

protocol HomeViewInterfaces {
    func prepare()
}

class HomeView: UIViewController {
    
    var viewModel = HomeViewModel()
    
    let titleAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.white,
        .font: UIFont.boldSystemFont(ofSize: 18)
    ]
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search Movie"
        return searchBar
    }()
    
    private let topRatedLabel = MyLabel(color: .white, fontSettings: .boldSystemFont(ofSize: 23),
                                        numberLines: 1)
    
    let topRatedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let sizeHeight = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: sizeHeight/5.8, height: sizeHeight/4)
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 5
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.layer.cornerRadius = 3
        collection.backgroundColor = .clear
        collection.register(TopRatedViewCell.self,
                            forCellWithReuseIdentifier: TopRatedViewCell.identifier)
        return collection
    }()
    
    private let popularLabel = MyLabel(color: .white, fontSettings: .boldSystemFont(ofSize: 20),
                                       numberLines: 1)
    
    let filmsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let sizeWidth = UIScreen.main.bounds.width
        let cellWidth = (sizeWidth - 70) / 3
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.4)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.layer.cornerRadius = 3
        collection.backgroundColor = .clear
        collection.register(FilmsViewCell.self,
                            forCellWithReuseIdentifier: FilmsViewCell.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}
// MARK: - Home View Interfaces
extension HomeView: HomeViewInterfaces {
    func prepare() {
        view.addSubview(searchBar)
        view.addSubview(topRatedLabel)
        view.addSubview(topRatedCollectionView)
        view.addSubview(popularLabel)
        view.addSubview(filmsCollectionView)
        
        makeSearchBarConst()
        makeTopRatedLabelConst()
        makeTopRatedConst()
        makePopularLabelConst()
        makeFilmsConst()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(filterButtonTapped))
        
        title = "Home"
        view.backgroundColor = UIColor(named: "system_background_color")
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        topRatedLabel.text = "Top Rated Movies"
        popularLabel.text = "Popular Movies"
        popularLabel.textColor = .white
        
        delegates()
    }
}

// MARK: - Delegates
extension HomeView {
    private func delegates() {
        topRatedCollectionView.dataSource = self
        topRatedCollectionView.delegate = self
        filmsCollectionView.dataSource = self
        filmsCollectionView.delegate = self
    }
}

// MARK: - CollectionView
extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var returnValue = 0
        
        if collectionView == topRatedCollectionView {
            returnValue = 10
        } else if collectionView == filmsCollectionView {
            returnValue = 20
        }
        
        return returnValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topRatedCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedViewCell.identifier,
                                                                for: indexPath) as? TopRatedViewCell else {
                return UICollectionViewCell()
            }
            cell.configCell(indexPath)
            return cell
        } else if collectionView == filmsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmsViewCell.identifier,
                                                                for: indexPath) as? FilmsViewCell else {
                return UICollectionViewCell()
            }
            cell.configCell(indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt()
    }
}

// MARK: - Filter Button
extension HomeView {
    @objc private func filterButtonTapped() {
        let genreArray = ["Action", "Comedy", "Dram", "Reset"]
        
        let alertController = UIAlertController(title: "Choose Movie Genre",
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        for genre in genreArray {
            let action = UIAlertAction(title: genre, style: .default)
            print(genre)
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive,
                                         handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Constraints
extension HomeView {
    private func makeSearchBarConst() {
        searchBar.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    private func makeTopRatedLabelConst() {
        topRatedLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(topRatedCollectionView.snp.top).offset(-10)
        }
    }
    
    private func makeTopRatedConst() {
        topRatedCollectionView.snp.makeConstraints { make in
            let sizeHeight = UIScreen.main.bounds.height
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(topRatedLabel.snp.bottom)
            make.height.equalTo(sizeHeight/4)
        }
    }
    
    private func makePopularLabelConst() {
        popularLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(topRatedCollectionView.snp.bottom).offset(10)
            make.bottom.equalTo(filmsCollectionView.snp.top).offset(-10)
        }
    }
    
    private func makeFilmsConst() {
        filmsCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(popularLabel.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
