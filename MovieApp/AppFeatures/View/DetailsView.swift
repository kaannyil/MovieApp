//
//  DetailsView.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 4.09.2023.
//

import UIKit
import UIFontComplete

protocol DetailsViewInterfaces {
    func prepare()
}

class DetailsView: UIViewController {
    
    var viewModel = DetailsViewModel()
    var isFaved = false

    let backGroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let foreGroundImage = MyImage(frame: .zero)
    
    let nameLabel = MyLabel(color: .white, fontSettings: .boldSystemFont(ofSize: 22),
                            numberLines: 2)
    private let aboutMovieLabel = MyLabel(color: .white, fontSettings: .boldSystemFont(ofSize: 18),
                                          numberLines: 1)
    let aboutMovieDetailLabel = MyLabel(color: .white, fontSettings: UIFont(font: .helvetica, size: 15)!,
                                        numberLines: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

// MARK: - Details View Interfaces
extension DetailsView: DetailsViewInterfaces {
    func prepare() {
        view.addSubview(backGroundImage)
        view.addSubview(foreGroundImage)
        view.addSubview(nameLabel)
        view.addSubview(aboutMovieLabel)
        view.addSubview(aboutMovieDetailLabel)
        
        makeBackGroundImageConst()
        makeForeGroundImageConst()
        makeNameLabelConst()
        makeAbotMovieLabelConst()
        makeAboutMovieDetailLabelConst()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .done, target: self, action: #selector(buttonTapped))
        
        title = "Details"
        view.backgroundColor = UIColor(named: "system_background_color")
        
        foreGroundImage.layer.cornerRadius = 20
        foreGroundImage.layer.borderWidth = 2
        foreGroundImage.layer.borderColor = UIColor(named: "system_blue")?.cgColor
        
        aboutMovieLabel.text = "About Movie"
        
        aboutMovieDetailLabel.sizeToFit()
    }
}

// MARK: - Button Tapped
extension DetailsView {
    func changeFavButtonImage(bool: Bool) {
        if bool == true {
            isFaved = bool
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .done, target: self, action: #selector(buttonTapped))
            print("Fav Button Active.")
        } else {
            isFaved = bool
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .done, target: self, action: #selector(buttonTapped))
            print("Fav Button Deactive.")
        }
    }
    
    @objc private func buttonTapped() {
        if isFaved == false {
            changeFavButtonImage(bool: true)
        } else {
            changeFavButtonImage(bool: false)
        }
    }
}

// MARK: - Constraints
extension DetailsView {
    private func makeBackGroundImageConst() {
        let sizeWidth = view.bounds.width
        backGroundImage.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.width.equalTo(sizeWidth)
            make.height.equalTo(sizeWidth/1.7777)
        }
    }
    
    private func makeForeGroundImageConst() {
        let sizeHeight = UIScreen.main.bounds.height
        foreGroundImage.snp.makeConstraints { make in
            make.height.equalTo(sizeHeight/5.5)
            make.width.equalTo(sizeHeight/7.5)
            make.centerY.equalTo(backGroundImage.snp.bottom)
            make.leading.equalTo(backGroundImage.snp.leading).offset(20)
        }
    }
    
    private func makeNameLabelConst() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(foreGroundImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(backGroundImage.snp.bottom).offset(-10)
            make.bottom.equalTo(foreGroundImage.snp.bottom)
        }
    }
    
    private func makeAbotMovieLabelConst() {
        aboutMovieLabel.snp.makeConstraints { make in
            make.leading.equalTo(foreGroundImage.snp.leading)
            make.trailing.equalTo(nameLabel.snp.trailing)
            make.top.equalTo(foreGroundImage.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
    }
    
    private func makeAboutMovieDetailLabelConst() {
        aboutMovieDetailLabel.snp.makeConstraints { make in
            make.leading.equalTo(foreGroundImage.snp.leading)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(aboutMovieLabel.snp.bottom).offset(10)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}
