//
//  WatchListViewCell.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 4.09.2023.
//

import UIKit

class WatchListViewCell: UICollectionViewCell {
    static let identifier = "WatchListViewCell"
    
    let imageView = MyImage(frame: .zero)
    let nameLabel = MyLabel(color: .white,
                            fontSettings: .boldSystemFont(ofSize: 22),
                            numberLines: 1)
    let ratingStarLabel = MyLabel(color: UIColor(named: "system_orange")!,
                                  fontSettings: .boldSystemFont(ofSize: 16),
                                  numberLines: 1)
    let genreLabel = MyLabel(color: .white, fontSettings: .boldSystemFont(ofSize: 16),
                             numberLines: 1)
    let releaseLabel = MyLabel(color: .white, fontSettings: .boldSystemFont(ofSize: 16),
                            numberLines: 1)
    let filmLengthLabel = MyLabel(color: .white, fontSettings: .boldSystemFont(ofSize: 16),
                                  numberLines: 1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingStarLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(releaseLabel)
        contentView.addSubview(filmLengthLabel)
        
        makeImageConst()
        makeNameConst()
        makeRatingStarConst()
        makeGenreConst()
        makeReleaseConst()
        makeFilmLengthConst()
    }
    
    public func configCell(movieDetail: MovieDetail, isFavedMovie: Bool) {
        
        let genres = movieDetail.genres
        imageView.uploadImage(posterPath: movieDetail.posterPath)
        nameLabel.text = movieDetail.title
        ratingStarLabel.text = "Rating : \(String(format: "%0.1f", movieDetail.voteAverage))"
        
        if !genres.isEmpty { genreLabel.text = "Genre: \(genres[0].name)" }
        
        print(movieDetail.genres)
        releaseLabel.text = "Release Date: \(movieDetail.releaseDate)"
        filmLengthLabel.text = "Minutes: \(String(movieDetail.runtime))"
    }
}

// MARK: - Constraints
extension WatchListViewCell {
    private func makeImageConst() {
        imageView.snp.makeConstraints { make in
            let sizeWidth = contentView.bounds.width
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(sizeWidth/3)
        }
    }
    
    private func makeNameConst() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalTo(imageView.snp.top)
        }
    }
    
    private func makeRatingStarConst() {
        ratingStarLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalTo(genreLabel.snp.top).offset(-5)
        }
    }
    
    private func makeGenreConst() {
        genreLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalTo(releaseLabel.snp.top).offset(-5)
        }
    }
    
    private func makeReleaseConst() {
        releaseLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalTo(filmLengthLabel.snp.top).offset(-5)
        }
    }
    
    private func makeFilmLengthConst() {
        filmLengthLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalTo(imageView.snp.bottom).offset(-10)
        }
    }
}
