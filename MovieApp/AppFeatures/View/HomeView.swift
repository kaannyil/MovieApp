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

protocol HomeViewOutPut: AnyObject {
    func saveMovies(movieType: MovieTypes, list: [MovieInfo])
}

class HomeView: UIViewController {
    
    var viewModel = HomeViewModel()
    
    var collectionCells = [CellItem]()
    
    var topRatedMovieList: [MovieInfo] = []
    var popularMovieList: [MovieInfo] = []

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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.scrollDirection = .horizontal
        let sizeHeight = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: sizeHeight/5.8, height: sizeHeight/4)
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 10
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.layer.cornerRadius = 3
        collection.backgroundColor = .clear
        collection.register(TopRatedViewCell.self,
                            forCellWithReuseIdentifier: TopRatedViewCell.identifier)
        return collection
    }()
    
    private let popularLabel = MyLabel(color: .white,
                                       fontSettings: .boldSystemFont(ofSize: 20),
                                       numberLines: 1)
    
    let popularCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
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
        viewModel.homeViewOutPut = self
        viewModel.fetchData()
        viewModel.viewDidLoad()
    }
    
    func configureCells() {
        collectionCells = [CellItem(cellType: .topRatedMovies, movieList: topRatedMovieList),
                           CellItem(cellType: .popularMovies, movieList: popularMovieList)]
    }
}
// MARK: - Home View Interfaces
extension HomeView: HomeViewInterfaces {
    func prepare() {
        view.addSubview(searchBar)
        view.addSubview(topRatedLabel)
        view.addSubview(topRatedCollectionView)
        view.addSubview(popularLabel)
        view.addSubview(popularCollectionView)
        
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
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
    }
}

// MARK: - View Model OutPut
extension HomeView: HomeViewOutPut {
    func saveMovies(movieType: MovieTypes, list: [MovieInfo]) {
        
        switch movieType {
        case .topRatedMovies:
            topRatedMovieList = list
        case .popularMovies:
            popularMovieList = list
        }
        configureCells()
        topRatedCollectionView.reloadData()
        popularCollectionView.reloadData()
    }
}

// MARK: - CollectionView
extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var returnValue = 0
        
        if collectionView == topRatedCollectionView {
            returnValue = topRatedMovieList.count
        } else if collectionView == popularCollectionView {
            returnValue = popularMovieList.count
        }
        
        return returnValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /* let section = collectionCells[indexPath.section]
        
        switch section.cellType {
        case .topRatedMovies:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedViewCell.identifier, for: indexPath) as! TopRatedViewCell
            
            let movie = self.topRatedMovieList[indexPath.item]
            cell.configCell(movie: movie, indexPath)
            return cell
            
        case .popularMovies:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmsViewCell.identifier, for: indexPath) as! FilmsViewCell
            
            let movie = self.popularMovieList[indexPath.item]
            cell.configCell(movie: movie)
            return cell
        } */
        
        if collectionView == topRatedCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedViewCell.identifier,
                                                                for: indexPath) as? TopRatedViewCell else {
                return UICollectionViewCell()
            }
            
            let movie = topRatedMovieList[indexPath.item]
            cell.configCell(movie: movie, indexPath)
            return cell
            
        } else if collectionView == popularCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmsViewCell.identifier, for: indexPath) as? FilmsViewCell else {
                return UICollectionViewCell()
            }
             
            let movie = popularMovieList[indexPath.item]
            cell.configCell(movie: movie)
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topRatedCollectionView {
            let id = topRatedMovieList[indexPath.item].id
            viewModel.segueToDetails(movieID: id)
            
        } else if collectionView == popularCollectionView {
            let id = popularMovieList[indexPath.item].id
            viewModel.segueToDetails(movieID: id)
        }
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
            make.bottom.equalTo(popularCollectionView.snp.top).offset(-10)
        }
    }
    
    private func makeFilmsConst() {
        popularCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.top.equalTo(popularLabel.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
