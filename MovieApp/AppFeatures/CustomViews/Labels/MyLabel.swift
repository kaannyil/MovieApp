//
//  MyLabel.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 5.09.2023.
//

import UIKit
import UIFontComplete

class MyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor, fontSettings: UIFont, numberLines: Int) {
        self.init(frame: .zero)
        font = fontSettings
        textColor = color
        numberOfLines = numberLines
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .left
    }
}
