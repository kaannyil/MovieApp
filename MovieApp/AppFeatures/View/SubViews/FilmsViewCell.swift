//
//  FilmsViewCell.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 2.09.2023.
//

import UIKit

class FilmsViewCell: UICollectionViewCell {
    static let identifier = "FilmsViewCell"
    
    let imageView = MyImage(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(imageView)
    
        imageViewConst()
    }
    
    public func configCell(_ indexpath: IndexPath) {
        imageView.image = UIImage(named: "movie2")
    }
}

// MARK: - Constraints
extension FilmsViewCell {
    private func imageViewConst() {
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
