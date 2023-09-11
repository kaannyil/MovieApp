//
//  MyImage.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 5.09.2023.
//

import UIKit

class MyImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        contentMode = .scaleToFill
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.masksToBounds = true
        contentMode = .scaleToFill
    }
    
    func uploadImage(posterPath: String) {
        imageFromUrl(urlString: posterPath, placeHolderImage: UIImage())
    }
}
