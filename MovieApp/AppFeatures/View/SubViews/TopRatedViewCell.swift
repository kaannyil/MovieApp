//
//  TopRatedViewCell.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 1.09.2023.
//

import UIKit
import UIFontComplete

class TopRatedViewCell: UICollectionViewCell {
    static let identifier = "TopRatedViewCell"
    
    let imageView = MyImage(frame: .zero)
    private let numberLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(numberLabel)
        
        imageViewConst()
        numberLabelConst()
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configNumberLabel(itemIndex: String){
        let strokeTextAttributes = [
            NSAttributedString.Key.strikethroughColor : UIColor(named: "system_background_color")!,
            NSAttributedString.Key.strokeColor : UIColor(named: "system_blue")!,
            NSAttributedString.Key.foregroundColor : UIColor(named: "system_background_color")!,
            NSAttributedString.Key.strokeWidth : -2,
            NSAttributedString.Key.font : UIFont(font: .helveticaBold, size: 80)!]
        as [NSAttributedString.Key : Any]

        numberLabel.attributedText = NSMutableAttributedString(string: itemIndex,
                                                               attributes: strokeTextAttributes)
    }
    
    public func configCell(movie: MovieInfo, _ indexpath: IndexPath) {
        configNumberLabel(itemIndex: String(indexpath.item + 1))
        // imageView.image = UIImage(named: "movie")
        imageView.uploadImage(posterPath: movie.posterPath)
    }
}

// MARK: - Constraints
extension TopRatedViewCell {
    private func imageViewConst() {
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func numberLabelConst() {
        numberLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(15)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(15)
        }
    }
}
